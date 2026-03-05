import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
abstract class SuccessSendEmailController extends GetxController {
  void goToSignIn();
  void openUserMailApp();
}


class SuccessSendEmailControllerImp extends SuccessSendEmailController {

  @override
  Future<void> openUserMailApp() async {
    try {
      await LaunchApp.openApp(
        androidPackageName: 'com.google.android.gm', 
        iosUrlScheme: 'googlegmail://',             
        appStoreLink: 'itms-apps://itunes.apple.com/app/gmail/id422689480',
      );
    } catch (e) {
      Get.snackbar("emailFailedToOpenMessageTitle".tr, "emailFailedToOpenMessageContent".tr);
    }
  }

  @override
  void goToSignIn() {
    Get.offAllNamed(AppRoutes.signIn);
  }
}