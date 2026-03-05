import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';

abstract class ChooseAuthMethodController extends GetxController {
  goToSignIn();
  goToSignUp();
}

class ChooseAuthMethodControllerImp extends ChooseAuthMethodController {
  @override
  goToSignIn() {
    Get.offNamed(AppRoutes.signIn);
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoutes.signUp);
  }
}
