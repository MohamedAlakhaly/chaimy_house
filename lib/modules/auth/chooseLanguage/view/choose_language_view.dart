import 'package:bubble/bubble.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/localization/local_controller.getx.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/modules/auth/sign_up/widget/custom_disable_button_widget.dart';
import 'package:chimay_house/modules/auth/chooseLanguage/controller/choose_language_controller.getx.dart';
import 'package:chimay_house/global/custom_choose_language_button.dart';
import 'package:rive/rive.dart';

class ChooseLanguageView extends StatelessWidget {
  const ChooseLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    ChooseLanguageControllerImp controller = Get.put(
      ChooseLanguageControllerImp(),
    );
    AppLocalController langController = Get.find();
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: controller.chooseLanguage,
        child: Container(
          height: 85,
          color: isDarkMode ? AppColors.bgDark : AppColors.bgLight,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GetBuilder<ChooseLanguageControllerImp>(
            builder: (myController) {
              return controller.currentLanguage == ''
                  ? CustomDisableButtonWidget(
                      buttonChild: Text('done button'.tr),
                      buttonColor: AppColors.primary.withValues(alpha: 0.3),
                    )
                  : CustomButtonWithShadow(
                      buttonText: 'done button'.tr,
                      buttonColor: AppColors.primary,
                    );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(width: double.infinity, height: 30),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: GetBuilder<ChooseLanguageControllerImp>(
                          builder: (myController) {
                            return RiveAnimation.asset(
                              'assets/animations/robot2.riv',
                              controllers: [controller.robotController],
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                    ),

                    GetBuilder<ChooseLanguageControllerImp>(
                      builder: (myController) {
                        return Expanded(
                          flex: 2,
                          child: Bubble(
                            nip:
                                controller.currentLanguage == 'ar' ||
                                    controller.currentLanguage == 'ps'
                                ? BubbleNip.rightCenter
                                : BubbleNip.leftCenter,
                            stick: true,
                            padding: const BubbleEdges.only(bottom: 20),
                            color: AppColors.customGrey.withValues(alpha: 0.3),
                            child: controller.currentLanguage != ''
                                ? Text(
                                    'language selected'.tr,
                                    style: TextStyle(
                                      fontSize: AppFontsSize.smallFontSize,
                                    ),
                                  )
                                : Text(
                                    controller.selectLanguage,
                                    style: TextStyle(
                                      fontSize: AppFontsSize.smallFontSize,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  itemCount: controller.languages.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GetBuilder<ChooseLanguageControllerImp>(
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
                                  : AppColors.primary.withValues(alpha: 0.3),
                              onTap: () {
                                //! update language and UI
                                controller.currentLanguage =
                                    controller.langCode[index];

                                //! chang local
                                langController.changeLocal(
                                  controller.langCode[index],
                                );

                                controller.update();
                              },
                            )
                            .animate()
                            .fadeIn(
                              delay: (200 + index * 100).ms,
                              duration: 600.ms,
                            )
                            .slideX(
                              begin: 0.2,
                              delay: (200 + index * 100).ms,
                              duration: 600.ms,
                              curve: Curves.easeOut,
                            );
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
