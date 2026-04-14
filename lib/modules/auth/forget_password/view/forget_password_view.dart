import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/modules/auth/forget_password/controller/forget_password_controller.getx.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordControllerImp controller = Get.put(
      ForgetPasswordControllerImp(),
    );
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SvgPicture.asset(AppImages.forgetPassword),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

              const SizedBox(height: 40),

              Text(
                    'forgotPasswordAppbar'.tr,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 500.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 500.ms),

              const SizedBox(height: 16),

              Text(
                    'forgotPasswordDescription'.tr,
                    style: TextStyle(
                      fontSize: AppFontsSize.smallFontSize,
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 600.ms),

              const SizedBox(height: 40),

              CustomTextFormFieldWidget(
                    hintText: 'enterYourEmail'.tr,
                    prefixIcon: Iconsax.sms,
                    controller: controller.emailController,
                  )
                  .animate()
                  .slideX(begin: -0.3, duration: 700.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 700.ms),

              const SizedBox(height: 32),

              Obx(() {
                return CustomButtonWithShadow(
                      buttonText: 'sendEmailButton'.tr,
                      buttonColor: AppColors.primary,
                      onTap: controller.sendEmail,
                      isCustomChild: controller.isLoading.value == false
                          ? false
                          : true,
                      customChild: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                    .fadeIn(duration: 800.ms);
              }),

              const SizedBox(height: 32),

              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'RememberYourPassword'.tr,
                    style: TextStyle(
                      color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontSize: AppFontsSize.smallFontSize,
                        ),
                      ),
                      SizedBox(width: 7),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(AppRoutes.signIn),
                        child: Text(
                          'signInButton'.tr,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: AppFontsSize.smallFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                  .fadeIn(duration: 900.ms),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
