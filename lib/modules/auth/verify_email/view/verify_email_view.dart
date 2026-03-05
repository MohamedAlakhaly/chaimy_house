import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/global/custom_normal_button.dart';
import 'package:chimay_house/modules/auth/verify_email/controller/verify_email_controller.getx.dart';
import 'package:iconsax/iconsax.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    VerifyEmailControllerImp controller = Get.put(VerifyEmailControllerImp());
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      //! AppBar
      appBar: CustomAppBar(title:'verifyEmailAppbar'.tr),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(width: double.infinity),
              //! SvgPicture
              SvgPicture.asset(AppImages.verifyEmail, height: 280),
          
              const SizedBox(height: 30),
              //! content text
              Text(
                textAlign: TextAlign.center,
                'verifyEmailContent'.tr,
                style: AppTextStyle.contentStyle,
              ),
              const SizedBox(height: 40),
          
              //! re send email button
              CustomButtonWithShadow(
                buttonText: 'checkYourEmailButton'.tr,
                onTap: controller.openUserMailApp,
                buttonColor: isDarkMode ? Colors.white : Colors.black,
                textColor: isDarkMode ? Colors.black : Colors.white,
              ),
              const SizedBox(height: 10),
          
              //! go to signIn button
              CustomButtonWithShadow(
                buttonText: 'signInButton'.tr,
                onTap: controller.goToSignIn,
                buttonColor: AppColors.primary,
              ),
          
              const SizedBox(height: 10),
              TextButton(
                onPressed: controller.reSendEmail,
                child: Text(
                  'resendEmailButton'.tr,
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
          
              const SizedBox(height: 10),
              Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.grey[800]?.withValues(alpha: 0.5)
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.info_circle,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'spamMessage'.tr,
                            style: TextStyle(
                              fontSize: AppFontsSize.extraSmallFontSize,
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
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
