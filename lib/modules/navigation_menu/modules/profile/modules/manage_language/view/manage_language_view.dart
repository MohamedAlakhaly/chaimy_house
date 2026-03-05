import 'dart:developer';

import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/localization/local_controller.getx.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_choose_language_button.dart';
import 'package:chimay_house/modules/auth/sign_up/widget/custom_disable_button_widget.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/manage_language/controller/manage_language_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageLanguageView extends StatelessWidget {
  const ManageLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    ManageLanguageControllerImp controller = Get.put(
      ManageLanguageControllerImp(),
    );
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'manageLanguageAppBarTitle'.tr),

      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: isDarkMode ? AppColors.bgDark : AppColors.bgLight,
        child: SafeArea(
          top: false,
          child: GetBuilder<ManageLanguageControllerImp>(
            builder: (myController) {
              return CustomDisableButtonWidget(
                buttonChild: Text(
                  'done button'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppFontsSize.mediumFontSize,
                  ),
                ),
                buttonColor:
                    controller.selectedLanguage == '' ||
                        controller.selectedLanguage == controller.appLanguage
                    ? AppColors.primary.withAlpha(80)
                    : AppColors.primary,
                onTapButton: () {
                  controller.currentLanguage == controller.appLanguage
                      ? {}
                      : controller.changeLanguage(
                          langCode: controller.selectedLanguage,
                        );
                },
              );
            },
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            ListView.separated(
              itemCount: controller.languages.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GetBuilder<ManageLanguageControllerImp>(
                  builder: (myController) {
                    return CustomChooseLanguageButton(
                      language: controller.languages[index],
                      flag: controller.flags[index],
                      borderColor:
                          controller.currentLanguage !=
                              controller.langCode[index]
                          ? AppColors.customGrey
                          : AppColors.primary,
                      bgColor:
                          controller.currentLanguage !=
                              controller.langCode[index]
                          ? Colors.transparent
                          : AppColors.primary.withAlpha(50),
                      onTap: () {
                        controller.currentLanguage = controller.langCode[index];
                        controller.selectedLanguage =
                            controller.langCode[index];
                        controller.update();
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
