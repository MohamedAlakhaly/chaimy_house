// import 'dart:developer';

// import 'package:chimay_house/core/services/app_services.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rive/rive.dart';

// abstract class ChangeThemeController extends GetxController {
//   changToLightMode();
//   changToDarkMode();
// }

// class ChangeThemeControllerImp extends ChangeThemeController {
//   bool isDarkMode = Get.isDarkMode;
//   RiveAnimationController? switchTheme; // وحدة التحكم بالأنميشن
//   AppServices services = Get.find();

//   @override
//   void onInit() {
//     // 1. تحديد الحالة البدئية بناءً على ما هو محفوظ
//     isDarkMode = services.sharedPreferences.getBool('lightMode') == false;
    
//     // 2. تشغيل الأنميشن المناسب عند بداية التطبيق
//     switchTheme = SimpleAnimation(isDarkMode ? 'Off' : 'On'); 
//     super.onInit();
//   }

//   @override
//   changToLightMode() async {
//     isDarkMode = false;
    
//     // تغيير الثيم فوراً في GetX
//     Get.changeThemeMode(ThemeMode.light);
    
//     // تحديث وحدة التحكم بالأنميشن لتشغيل حركة 'On'
//     switchTheme = SimpleAnimation('On');
    
//     await services.sharedPreferences.setBool('lightMode', true);
//     update(); // لتحديث الواجهة التي تحتوي على الـ Rive Animation
//   }

//   @override
//   changToDarkMode() async {
//     isDarkMode = true;
    
//     // تغيير الثيم فوراً في GetX
//     Get.changeThemeMode(ThemeMode.dark);
    
//     // تحديث وحدة التحكم بالأنميشن لتشغيل حركة 'Off'
//     switchTheme = SimpleAnimation('Off');
    
//     await services.sharedPreferences.setBool('lightMode', false);
//     update(); // لتحديث الواجهة التي تحتوي على الـ Rive Animation
//   }
// }

import 'dart:developer';

import 'package:chimay_house/core/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

abstract class ChangeThemeController extends GetxController {
  changToLightMode();
  changToDarkMode();
}

class ChangeThemeControllerImp extends ChangeThemeController {
  bool isDarkMode = Get.isDarkMode;
  RiveAnimationController? switchTheme;
  AppServices services = Get.find();



  @override
  changToLightMode() async{
    if(isDarkMode == false) return; 
    isDarkMode = false;
    Get.changeThemeMode(ThemeMode.light);
    switchTheme!.isActive = true;
    switchTheme = SimpleAnimation('On');
    await services.sharedPreferences.setBool('lightMode', true);
    // log(message)
    update();
  }

  @override
  changToDarkMode() async{
    if(isDarkMode == true) return;
    isDarkMode = true;
    Get.changeThemeMode(ThemeMode.dark);
    switchTheme!.isActive = true;
    switchTheme = SimpleAnimation('Off');
    await services.sharedPreferences.setBool('lightMode', false);
    update();
  }

  @override
  void onInit() {
    // currentTheme = services.sharedPreferences.getBool('lightMode') ?? false;
    switchTheme = SimpleAnimation(isDarkMode ? 'Light' : 'Dark');
    super.onInit();
  }

  @override
  void dispose() {
    switchTheme!.dispose();
    super.dispose();
  }
}
