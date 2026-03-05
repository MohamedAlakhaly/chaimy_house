import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/modules/auth/logic_view/controller/logic_auth_controller.getx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class WaitingForActivationController extends GetxController {}

class WaitingForActivationControllerImp extends WaitingForActivationController {
  LogicAuthControllerImp logicAuthController = Get.find();
  final curret = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  void checkUser() async {
    isLoading = true;
    update();
    final userData = await logicAuthController.getUserFromFirestore(
      curret!.uid,
    );
    logicAuthController.user.value = userData;
    if (logicAuthController.user.value!.isActive == false) {
      Get.snackbar('noActivationMessageTitle'.tr, 'noActivationMessageDescription'.tr);
      isLoading = false;
      update();
      return;
    }

    Get.offNamed(AppRoutes.navigationMenu);
    return;
  }
}
