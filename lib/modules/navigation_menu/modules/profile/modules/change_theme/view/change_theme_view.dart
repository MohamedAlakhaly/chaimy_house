import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/change_theme/controller/change_theme_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChangeThemeView extends StatelessWidget {
  const ChangeThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeThemeControllerImp controller = Get.put(ChangeThemeControllerImp());
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity, height: 50),
              
              SizedBox(
                height: 300,
                width: 300,
                child: GetBuilder<ChangeThemeControllerImp>(
                  builder: (myController) {
                    return RiveAnimation.asset(
                      AppImages.switchTheme,
                      controllers: [controller.switchTheme!],
                    );
                  },
                ),
              ).animate().fade(duration: 800.ms).scale(delay: 200.ms, begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.easeOutBack),

              const SizedBox(height: 40),

              Column(
                children: [
                  Text(
                    'changeAppThemeTitle'.tr,
                    style: AppTextStyle.titleStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'changeAppThemeDescription'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.contentStyle.copyWith(wordSpacing: 3),
                  ),
                ],
              ).animate().slideY(begin: 0.3, end: 0, duration: 500.ms).fade(),

              const SizedBox(height: 40),

              GetBuilder<ChangeThemeControllerImp>(builder: (myController) {
                return Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // زر الـ Dark Mode
                      _buildThemeButton(

                        label: 'darkButton'.tr,
                        isSelected: controller.isDarkMode,
                        onTap: controller.changToDarkMode,
                        textColor: controller.isDarkMode ? Colors.white : Colors.grey,
                        isDarkMode: isDarkMode
                      ),
                      
                      // زر الـ Light Mode
                      _buildThemeButton(
                        label: 'lightButton'.tr,
                        isSelected: !controller.isDarkMode,
                        onTap: controller.changToLightMode,
                        textColor: !controller.isDarkMode ? Colors.white : Colors.grey,
                        isDarkMode: isDarkMode
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 400.ms);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color textColor,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 100.ms,
        curve: Curves.ease,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          boxShadow: isSelected 
              ? [BoxShadow(color: AppColors.primary.withValues(alpha:0.3), blurRadius: 10, spreadRadius: 1)]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isDarkMode ? Colors.white : (isSelected ? Colors.white : Colors.black54),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    ).animate().shimmer(
      duration: 1500.ms,
      color: Colors.white.withValues(alpha: 0.2),
    );
  }
}