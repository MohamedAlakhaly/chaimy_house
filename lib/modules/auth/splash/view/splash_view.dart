import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/modules/auth/splash/controller/splash_controller.getx.dart';
import 'package:rive/rive.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashControllerImp());
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          SizedBox(
            width: 300,
            height: 300,
            child: RiveAnimation.asset(
              'assets/animations/robot2.riv',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'ILA',
            style: TextStyle(
              fontSize: AppFontsSize.extraLargeFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
