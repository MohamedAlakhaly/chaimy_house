import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignUpController extends GetxController {
  void showPassword();
  void goToSignIn();
  void signUp();
}

class SignUpControllerImp extends SignUpController {
  bool obscureText = true;
  bool agreePrivate = false;
  IconData visibilityIcon = Icons.visibility_off_outlined;
  bool isLoading = false;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late TextEditingController roomNumberController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  showPassword() {
    obscureText = !obscureText;
    visibilityIcon = obscureText
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    update();
  }

  @override
  goToSignIn() {
    Get.toNamed(AppRoutes.signIn);
  }

  @override
  signUp() async {
    if (globalKey.currentState!.validate()) {
      if (agreePrivate) {
        try {
          isLoading = true;
          update();

          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );

          await userCredential.user!.sendEmailVerification();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
                'userId': userCredential.user!.uid,
                'roomNumber': int.tryParse(roomNumberController.text) ?? 0,
                'isActive': false,
                'username': usernameController.text.trim(),
                'email': emailController.text.trim(),
                'createAt': Timestamp.now(),
                'role': 'user',
                'provider': 'email',
                'imageUrl': '',
              });

          Get.offAllNamed(AppRoutes.verifyEmail);
        } on FirebaseAuthException catch (e) {
          _handleAuthError(e);
        } catch (e) {
          Get.snackbar(
            'accountCreationFailedTitle'.tr,
            'accountCreationFailedContent'.tr,
          );
        } finally {
          isLoading = false;
          update();
        }
      } else {
        Get.snackbar('privacyPolicyOffTitle'.tr, 'privacyPolicyOffContent'.tr);
      }
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    if (e.code == 'weak-password') {
      Get.snackbar('weakPasswordTitle'.tr, 'weakPasswordContent'.tr);
    } else if (e.code == 'email-already-in-use') {
      Get.snackbar('emailAlreadyInUseTitle'.tr, 'emailAlreadyInUseContent'.tr);
    } else {
      Get.snackbar(
        'accountCreationFailedTitle'.tr,
        'accountCreationFailedContent'.tr,
      );
    }
  }

  @override
  void onInit() {
    roomNumberController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _googleSignIn.initialize(
      serverClientId:
          "324540492115-fblrk9lj7sln45212o47iuaq1a0rvvaj.apps.googleusercontent.com",
    );
    super.onInit();
  }

  @override
  void dispose() {
    roomNumberController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
