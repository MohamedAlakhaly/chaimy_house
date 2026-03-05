import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocalController extends GetxController {
  changeLocal(String langCode) {
    Locale locale = Locale(langCode);
    Get.updateLocale(locale);
  }
}
