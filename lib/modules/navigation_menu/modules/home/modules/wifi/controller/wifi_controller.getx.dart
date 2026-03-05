import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class WifiController extends GetxController {
  void createQrCode(String wifiName, String wifiPassword);
}

class WifiControllerImp extends WifiController {
  final String password = "WelcomeToMotel6460";
  final String networkName = "Motel-22 / motelila";
  String wifiQR = '';
  RxBool isCopy = false.obs;
  @override
  void createQrCode(String wifiName, String wifiPassword) {
    wifiQR = "WIFI:T:WPA;S:$wifiName;P:$wifiPassword;;";
  }

  void copyWifiPassword() async {
    await Clipboard.setData(ClipboardData(text: password));
    isCopy.value = true;

    Get.snackbar(
      'successCopyPasswordMessageTitle'.tr,
      'successCopyPasswordMessageContent'.tr,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
    await Future.delayed(Duration(seconds: 3));
    isCopy.value = false;
  }
}
