import 'package:bubble/bubble.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/localization/local_controller.getx.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/global/custom_choose_language_button.dart';
import 'package:chimay_house/modules/auth/chooseLanguage/controller/choose_language_controller.getx.dart';
import 'package:chimay_house/modules/auth/sign_up/widget/custom_disable_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // إضافة المكتبة
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class ChooseLanguageView extends StatelessWidget {
  const ChooseLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    ChooseLanguageControllerImp controller = Get.put(ChooseLanguageControllerImp());
    AppLocalController langController = Get.find();
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GetBuilder<ChooseLanguageControllerImp>(
        builder: (myController) {
          return Container(
            height: 90,
            width: double.infinity,
            color: isDarkMode ? AppColors.bgDark : AppColors.bgLight,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: controller.currentLanguage == ''
                ? CustomDisableButtonWidget(
                    buttonChild: Text('done button'.tr),
                    buttonColor: AppColors.primary.withValues(alpha: 0.3),
                  )
                : CustomButtonWithShadow(
                    buttonText: 'done button'.tr,
                    buttonColor: AppColors.primary,
                    onTap: controller.chooseLanguage,
                  ).animate().scale(duration: 200.ms, curve: Curves.bounceOut),
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(width: double.infinity, height: 20),
                
                // الروبوت والفقاعة
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 180,
                        child: RiveAnimation.asset(
                          'assets/animations/robot2.riv',
                          controllers: [controller.robotController],
                          fit: BoxFit.contain,
                        ),
                      ).animate().slideX(begin: -0.5, end: 0, duration: 800.ms, curve: Curves.easeOutBack),
                    ),
                    Expanded(
                      flex: 2,
                      child: GetBuilder<ChooseLanguageControllerImp>(
                        builder: (myController) {
                          return Bubble(
                            nip: (controller.currentLanguage == 'ar' || controller.currentLanguage == 'ps')
                                ? BubbleNip.rightCenter
                                : BubbleNip.leftCenter,
                            stick: true,
                            elevation: 2,
                            padding: const BubbleEdges.all(12),
                            color: isDarkMode ? Colors.grey[800] : Colors.white,
                            child: Text(
                              controller.currentLanguage != '' 
                                  ? 'language selected'.tr 
                                  : controller.selectLanguage,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                          )
                          .animate(key: ValueKey(controller.currentLanguage)) // إعادة الأنميشن عند تغيير النص
                          .shake(duration: 400.ms)
                          .fadeIn();
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // قائمة اللغات مع Staggered Animation
                AnimationLimiter(
                  child: ListView.separated(
                    itemCount: controller.languages.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 600),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: GetBuilder<ChooseLanguageControllerImp>(
                              builder: (myController) {
                                bool isSelected = controller.currentLanguage == controller.langCode[index];
                                return CustomChooseLanguageButton(
                                  language: controller.languages[index],
                                  flag: controller.flags[index],
                                  borderColor: isSelected ? AppColors.primary : AppColors.customGrey,
                                  bgColor: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                                  onTap: () {
                                    controller.currentLanguage = controller.langCode[index];
                                    langController.changeLocal(controller.langCode[index]);
                                    controller.update();
                                  },
                                )
                                .animate(target: isSelected ? 1 : 0)
                                .scale(end: const Offset(1.02, 1.02), duration: 200.ms);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}