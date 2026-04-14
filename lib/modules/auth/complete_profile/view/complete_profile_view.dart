import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/functions/input_validation.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/modules/auth/complete_profile/controller/complete_profile_controller.dart';
import 'package:chimay_house/modules/auth/sign_up/widget/custom_disable_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CompleteProfileControllerImp());

    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(title: Text('completeProfileAppbar'.tr), centerTitle: true),
      body: GetBuilder<CompleteProfileControllerImp>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                 Text(
                  'completeProfileContent'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                CustomTextFormFieldWidget(
                      controller: controller.roomNumberController,
                      hintText: 'roomNumber'.tr,
                      prefixIcon: Iconsax.user,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        return inputValidation(2, 1, val!, 'roomNumber');
                      },
                    )
                    .animate()
                    .slideX(begin: -0.1, duration: 500.ms, delay: 100.ms)
                    .fadeIn(duration: 600.ms),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: AppColors.primary,
                      value: controller.agreePrivate,
                      onChanged: (val) {
                        controller.agreePrivate = val!;
                        controller.update();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Expanded(
                          child: Text(
                            'agree privacy'.tr,
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey[300]
                                  : Colors.grey[700], // Better color handling
                            ),
                          ),
                        )
                        .animate()
                        .slideY(begin: 0.2, duration: 500.ms, delay: 500.ms)
                        .fadeIn(duration: 600.ms),
                  ],
                ),
                const SizedBox(height: 20),
                CustomDisableButtonWidget(
                      buttonChild: !controller.isLoading
                          ? Text(
                              'create account'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: AppFontsSize.smallFontSize,
                              ),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      buttonColor: controller.agreePrivate == true
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.5),
                      onTapButton: () {
                        controller.updateRoomNumber();
                      },
                    )
                    .animate()
                    .scale(
                      begin: Offset(0.9, 0.9),
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 700.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
