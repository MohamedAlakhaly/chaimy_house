import 'dart:developer';
import 'package:chimay_house/modules/auth/complete_profile/view/complete_profile_view.dart';
import 'package:chimay_house/modules/auth/logic_view/view/logic_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignInController extends GetxController {
  void signIn();
  void goToSignUp();
  void goToForgetPassword();
}

class SignInControllerImp extends SignInController {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscureText = true;
  bool agreePrivate = false;
  bool isLoading = false;
  IconData visibilityIcon = Icons.visibility_off_outlined;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  signIn() async {
    if (globalKey.currentState!.validate()) {
      try {
        isLoading = true;
        update();
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          Get.offAll(() => LogicView());
        } else {
          Get.snackbar('emailNotVerifyTitle'.tr, 'emailNotVerifyContent'.tr);
          isLoading = false;
        }
        update();
      } on FirebaseAuthException catch (e) {
        Get.snackbar(
          'checkEmailOrPasswordTitle'.tr,
          'checkEmailOrPasswordContent'.tr,
        );
        isLoading = false;
        update();
        log(e.toString());
      }
    }
  }


  @override
  goToSignUp() async {
    Get.offAllNamed(AppRoutes.signUp);
  }

  void showPassword() {
    obscureText = !obscureText;
    obscureText == true
        ? visibilityIcon = Icons.visibility_off_outlined
        : visibilityIcon = Icons.visibility_outlined;
    update();
  }

  @override
  void onInit() {
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }
}
