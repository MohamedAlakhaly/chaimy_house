import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_choose_language_button.dart';
import 'package:chimay_house/modules/auth/sign_up/widget/custom_disable_button_widget.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/manage_language/controller/manage_language_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// استيراد المكتبات الجديدة
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
              // استخدام flutter_animate لتحريك زر التأكيد عند تفعيله
              return CustomDisableButtonWidget(
                buttonChild: Text(
                  'done button'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppFontsSize.mediumFontSize,
                  ),
                ),
                buttonColor: controller.selectedLanguage == '' ||
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
              )
              .animate(target: (controller.selectedLanguage != '' && controller.selectedLanguage != controller.appLanguage) ? 1 : 0)
              .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 200.ms)
              .then()
              .shake(hz: 4, curve: Curves.easeInOut); 
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // إضافة AnimationLimiter لتفعيل الـ Staggered Animation
            AnimationLimiter(
              child: ListView.separated(
                itemCount: controller.languages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // تم التغيير لأننا داخل SingleChildScrollView
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: GetBuilder<ManageLanguageControllerImp>(
                          builder: (myController) {
                            bool isSelected = controller.currentLanguage == controller.langCode[index];
                            
                            return CustomChooseLanguageButton(
                              language: controller.languages[index],
                              flag: controller.flags[index],
                              borderColor: !isSelected
                                  ? AppColors.customGrey
                                  : AppColors.primary,
                              bgColor: !isSelected
                                  ? Colors.transparent
                                  : AppColors.primary.withAlpha(50),
                              onTap: () {
                                controller.currentLanguage = controller.langCode[index];
                                controller.selectedLanguage = controller.langCode[index];
                                controller.update();
                              },
                            )
                            // إضافة أنميشن بسيط عند اختيار اللغة باستخدام flutter_animate
                            .animate(target: isSelected ? 1 : 0)
                            .shimmer(duration: 1200.ms, color: AppColors.primary.withAlpha(30))
                            .scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02));
                          },
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 10),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}