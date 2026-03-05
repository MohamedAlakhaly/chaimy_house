import 'dart:developer';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';

abstract class VerifyEmailController extends GetxController {
  void reSendEmail();
  void goToSignIn();
  void openUserMailApp();
}

class VerifyEmailControllerImp extends VerifyEmailController {
  @override
  goToSignIn() {
    Get.offAllNamed(AppRoutes.signIn);
  }

  @override
  reSendEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Get.snackbar(
        'verificationEmailSentTitle'.tr,
        'verificationEmailSentContent'.tr,
      );
    } on FirebaseException catch (e) {
      Get.snackbar(
        'accessTemporarilyBlockedTitle'.tr,
        'accessTemporarilyBlockedContent'.tr,
      );
      log(e.message!);
    }
  }

  @override
  Future<void> openUserMailApp() async {
    try {
      await LaunchApp.openApp(
        androidPackageName: 'com.google.android.gm',
        iosUrlScheme: 'googlegmail://',
        appStoreLink: 'itms-apps://itunes.apple.com/app/gmail/id422689480',
      );
    } catch (e) {
      Get.snackbar(
        "emailFailedToOpenMessageTitle".tr,
        "emailFailedToOpenMessageContent".tr,
      );
    }
  }
}
