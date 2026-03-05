import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/modules/auth/success_send_email/controller/success_send_email_controller.getx.dart';

class SuccessSendEmailView extends StatelessWidget {
  const SuccessSendEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSendEmailControllerImp controller = Get.put(
      SuccessSendEmailControllerImp(),
    );
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.1),
                            AppColors.primary,
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
                      child: SvgPicture.asset(AppImages.success),
                    )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.elasticOut)
                    .then(delay: 200.ms)
                    .shake(duration: 400.ms),

                const SizedBox(height: 40),

                Text(
                      'successSendEmailAppbar'.tr,
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
                      'successSendEmailDescription'.tr,
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

                const SizedBox(height: 50),

                CustomButtonWithShadow(
                      buttonText: 'openEmailButton'.tr,
                      buttonColor: AppColors.primary,
                      onTap: controller.openUserMailApp,
                    )
                    .animate()
                    .slideX(
                      begin: -0.2,
                      duration: 700.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(duration: 700.ms),

                const SizedBox(height: 16),

                CustomButtonWithShadow(
                      buttonText: 'backToSignIn'.tr,
                      buttonColor: isDarkMode ? Colors.white : Colors.black,
                      textColor: isDarkMode ? Colors.black : Colors.white,
                      onTap: controller.goToSignIn,
                    )
                    .animate()
                    .slideX(begin: 0.2, duration: 800.ms, curve: Curves.easeOut)
                    .fadeIn(duration: 800.ms),

                SizedBox(height: 50),

                Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.grey[800]?.withValues(alpha: 0.5)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode
                              ? Colors.grey[700]!
                              : Colors.grey[300]!,
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
