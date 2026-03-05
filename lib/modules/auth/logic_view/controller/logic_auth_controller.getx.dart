import 'dart:async';
import 'dart:developer';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:chimay_house/modules/admin/view/admin_view.dart';
import 'package:chimay_house/modules/auth/chooseLanguage/view/choose_language_view.dart';
import 'package:chimay_house/modules/auth/sign_in/view/sign_in_view.dart';
import 'package:chimay_house/modules/auth/waiting_for_activation/view/waiting_for_activation_view.dart';
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
    FirebaseAuth.instance.idTokenChanges().listen((user) async {
      if (user == null) {
        bool hasChosenLanguage =
            services.sharedPreferences.getBool('hasChosenLanguage') ?? false;
        if (hasChosenLanguage) {
          Get.offAll(() => SignInView());
        } else {
          Get.offAll(() => ChooseLanguageView());
        }
        return;
      }

      log("User is signed in: ${user.uid}");

      final userData = await getUserFromFirestore(user.uid);

      if (userData == null) {
        log('user null');
        Get.offAll(() => ChooseLanguageView());
        return;
      }

      if (userData.role == 'admin') {
        Get.offAll(() => AdminView());
        return;
      }

      if (userData.isActive == false) {
        Get.offAll(() => WaitingForActivationView());
        return;
      }

      Get.offAllNamed(AppRoutes.navigationMenu);
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


// abstract class LogicAuthController extends GetxController {
//   initApp();
// }

// class LogicAuthControllerImp extends LogicAuthController {
//   final Rx<UserModel?> user = Rx<UserModel?>(null);

//   Future<UserModel?> getUserFromFirestore(String uid) async {
//     final doc = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//     log('====================== ${doc.data()}');
//     if (doc.exists) {
//       return UserModel.fromMap(doc.data()!, doc.id);
//     }
//     return null;
//   }

//   @override
//   @override
// initApp() async {
//   final current = FirebaseAuth.instance.currentUser;

//   // 1. إذا كان المستخدم مسجل دخول وبريده مفعل
//   if (current != null && current.emailVerified) {
//     final userData = await getUserFromFirestore(current.uid);
    
//     if (userData != null) {
//       user.value = userData;
      
//       if (user.value!.role == 'admin') {
//         Get.offAll(() => AdminView());
//         return;
//       }
      
//       if (user.value!.isActive == false) {
//         Get.offAll(() => WaitingForActivationView());
//         return;
//       }

//       Get.offAllNamed(AppRoutes.navigationMenu);
//       return;
//     }
//   }

  
//   Get.offAll(()=> ChooseLanguageView());
// }

//   @override
//   void onInit() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       initApp();
//     });
//     super.onInit();
//   }
// }

// class LogicAuthControllerImp extends LogicAuthController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final Rx<UserModel?> user = Rx<UserModel?>(null);
  
//   // تعريف الـ Stream للاستماع لتغيرات حالة التسجيل
//   late Rx<User?> firebaseUser;

//   @override
//   void onReady() {
//     super.onReady();
//     // ربط المتغير بحالة Firebase
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.authStateChanges());
    
//     // الاستماع لأي تغيير في firebaseUser وتنفيذ دالة initApp تلقائياً
//     ever(firebaseUser, _setInitialScreen);
//   }

//   _setInitialScreen(User? current) async {
//     if (current == null) {
//       // إذا لم يسجل دخول، اذهب لصفحة اللغة أو الترحيب
//       Get.offAllNamed(AppRoutes.chooseLanguage);
//     } else {
//       // إذا سجل دخول، تأكد من بريده وجلب بياناته من Firestore
//       if (current.emailVerified) {
//         final userData = await getUserFromFirestore(current.uid);
//         if (userData != null) {
//           user.value = userData;
          
          
//           if (userData.role == 'admin') {
//             Get.offAll(() => const AdminView());
//           } else if (userData.isActive == false) {
//             Get.offAll(() => const WaitingForActivationView());
//           } else {
//             Get.offAllNamed(AppRoutes.navigationMenu);
//           }
//         }
//       } else {
//         // إذا لم يوثق البريد (اختياري)
//         Get.offAllNamed(AppRoutes.signIn); 
//       }
//     }
//   }

//   Future<UserModel?> getUserFromFirestore(String uid) async {
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
//       if (doc.exists) {
//         return UserModel.fromMap(doc.data()!, doc.id);
//       }
//     } catch (e) {
//       log("Error fetching user: $e");
//     }
//     return null;
//   }
// }





// class LogicAuthControllerImp extends LogicAuthController {
//   final Rx<UserModel?> user = Rx<UserModel?>(null);

//   /// جلب بيانات المستخدم من Firestore
//   Future<UserModel?> getUserFromFirestore(String uid) async {
//     try {
//       final doc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uid)
//           .get();

//       log('User Data: ${doc.data()}');

//       if (doc.exists && doc.data() != null) {
//         return UserModel.fromMap(doc.data()!, doc.id);
//       }
//     } catch (e) {
//       log('Error getting user: $e');
//     }
//     return null;
//   }

//   /// التنقل حسب حالة المستخدم
//   Future<void> handleUser(User current) async {
//     final userData = await getUserFromFirestore(current.uid);

//     /// لو المستخدم موجود في Auth لكن غير موجود في Firestore
//     if (userData == null) {
//       log("User exists in Auth but not in Firestore. Logging out...");
//       await FirebaseAuth.instance.signOut();
//       Get.offAllNamed(AppRoutes.chooseLanguage);
//       return;
//     }

//     user.value = userData;

//     /// التحقق من الدور
//     if (user.value!.role == 'admin') {
//       Get.offAll(() => const AdminView());
//       return;
//     }

//     /// التحقق من التفعيل
//     if (user.value!.isActive == false) {
//       Get.offAll(() => const WaitingForActivationView());
//       return;
//     }

//     /// المستخدم طبيعي
//     Get.offAllNamed(AppRoutes.navigationMenu);
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     /// الاستماع لحالة تسجيل الدخول
//     FirebaseAuth.instance.authStateChanges().listen((User? current) async {
//       if (current == null) {
//         Get.offAllNamed(AppRoutes.chooseLanguage);
//         return;
//       }

//       /// لو تحب تفعل شرط توثيق الإيميل فعل هذا:
//       /*
//       if (!current.emailVerified) {
//         Get.offAllNamed(AppRoutes.verifyEmail);
//         return;
//       }
//       */

//       await handleUser(current);
//     });
//   }
// }

