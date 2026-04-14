import 'dart:async';
import 'dart:developer';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class LogicAuthController extends GetxController {
  void initApp();
}

class LogicAuthControllerImp extends LogicAuthController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);
  StreamSubscription<User?>? _authSubscription;
  AppServices services = Get.find<AppServices>();
  bool isNavigating = false;

  Future<UserModel?> getUserFromFirestore(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  @override
  initApp() {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (isNavigating) return;

      if (user == null) {
        isNavigating = true;
        bool hasChosenLanguage = services.sharedPreferences.getBool('hasChosenLanguage') ?? false;
        Get.offAllNamed(hasChosenLanguage ? AppRoutes.signIn : AppRoutes.chooseLanguage);
        isNavigating = false;
        return;
      }

      
      if (!user.emailVerified && user.providerData.any((p) => p.providerId == 'password')) {
        log("User email not verified, staying/going to VerifyEmailView");
        Get.snackbar('userEmailNotVerifiedTitle'.tr, 'userEmailNotVerifiedContent'.tr);
        Get.offAllNamed(AppRoutes.verifyEmail);
        return; 
      }

      log("Checking user data for: ${user.uid}");
      isNavigating = true;

      UserModel? userData;
      int retryCount = 0;
      while (userData == null && retryCount < 3) {
        userData = await getUserFromFirestore(user.uid);
        if (userData == null) {
          await Future.delayed(const Duration(seconds: 1));
          retryCount++;
        }
      }

      if (userData == null) {
        log('User not found after retries, signing out...');
        await FirebaseAuth.instance.signOut();
        isNavigating = false;
        Get.snackbar('userNotFoundTitle'.tr, 'userNotFoundContent'.tr);
        return;
      }

       
      String targetRoute;
      if (userData.role == 'admin') {
        targetRoute = AppRoutes.adminView;
      } else if (userData.roomNumber == 0 || userData.roomNumber == null) {
        targetRoute = AppRoutes.completeProfile;
      } else if (userData.isActive == false) {
        targetRoute = AppRoutes.waitingForActivation;
      } else {
        targetRoute = AppRoutes.navigationMenu;
      }

      Get.offAllNamed(targetRoute);
      await Future.delayed(const Duration(milliseconds: 500));
      isNavigating = false; 
    });
  }

  @override
  void onInit() {
    initApp();
    super.onInit();
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    super.onClose();
  }
}
