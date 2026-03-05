import 'dart:developer';

import 'package:chimay_house/core/services/app_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';

abstract class ForgetPasswordController extends GetxController {
  void sendEmail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  late TextEditingController emailController;
  AppServices services = Get.find<AppServices>();
  RxBool isLoading = false.obs;

  @override
  void sendEmail() async {
    String langCode = services.sharedPreferences.getString('langCode') ?? 'en';
    try {
      isLoading.value = true;
      await FirebaseAuth.instance.setLanguageCode(langCode);
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Get.offAllNamed(AppRoutes.successSendEmail);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "errorSendingLinkToChangePasswordTitle".tr,
        "errorSendingLinkToChangePasswordContent".tr,
      );
      isLoading.value = false;
      log(e.message!);
    } catch (e) {
      Get.snackbar(
        "problemConnectingToServerTitle".tr,
        "problemConnectingToServerContent".tr,
      );
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
