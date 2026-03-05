import 'package:chimay_house/modules/auth/logic_view/view/logic_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';

abstract class SplashController extends GetxController {
  initApp();
}

class SplashControllerImp extends SplashController {
  // @override
  // initApp() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   FirebaseAuth.instance.currentUser != null &&
  //           FirebaseAuth.instance.currentUser!.emailVerified
  //       ? Get.offNamed(AppRoutes.navigationMenu)
  //       : Get.offNamed(AppRoutes.chooseLanguage);
  // }

  @override
  initApp() async{
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => LogicView());
  }

  @override
  void onInit() {
    initApp();
    super.onInit();
  }
}
