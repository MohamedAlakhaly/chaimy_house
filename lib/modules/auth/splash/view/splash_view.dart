import 'package:blur/blur.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/modules/auth/splash/controller/splash_controller.getx.dart';
import 'package:rive/rive.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    Get.put(SplashControllerImp());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Blur(
                  blur: 5,
                  blurColor: isDarkMode? Colors.transparent : Colors.white.withValues(alpha: 0.5),
                  child: SizedBox(
                    width: double.infinity,
                    height: height,
                    child: const RiveAnimation.asset(
                      'assets/animations/splash3.riv',
                      useArtboardSize: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        fontSize: AppFontsSize.extraLargeFontSize+10,
                        fontWeight: FontWeight.bold,
                        color:isDarkMode? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: const Duration(milliseconds: 500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
