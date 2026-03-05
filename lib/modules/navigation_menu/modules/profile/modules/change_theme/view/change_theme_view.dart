import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/change_theme/controller/change_theme_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rive/rive.dart';

class ChangeThemeView extends StatelessWidget {
  const ChangeThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeThemeControllerImp controller = Get.put(ChangeThemeControllerImp());
    return Scaffold(
      appBar: CustomAppBar(title: ''),
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
              ),
              const SizedBox(height: 40),
              Text(
                'changeAppThemeTitle'.tr,
                style: AppTextStyle.titleStyle,
              ),
              Text(
                'changeAppThemeDescription'.tr,
                textAlign: TextAlign.center,
                style: AppTextStyle.contentStyle.copyWith(wordSpacing: 3),
              ),
              const SizedBox(height: 40),
              GetBuilder<ChangeThemeControllerImp>(builder: (myController) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: controller.changToDarkMode,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          decoration: BoxDecoration(
                              color: controller.isDarkMode
                                  ? AppColors.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            'darkButton'.tr,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.changToLightMode,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: !controller.isDarkMode
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                          child: Text(
                            'lightButton'.tr,
                            style: TextStyle(
                                color: controller.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
