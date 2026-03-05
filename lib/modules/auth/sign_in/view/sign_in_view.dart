import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/functions/input_validation.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/modules/auth/sign_in/controller/sign_in_controller.getx.dart';

class SignInView extends GetView<SignInControllerImp> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInControllerImp());
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: controller.globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDarkMode
                            ? [
                                AppColors.primary.withValues(alpha: 0.7),
                                AppColors.primary.withValues(alpha: 0.5)
                              ]
                            : [
                                AppColors.primary.withValues(alpha: 0.9),
                                AppColors.primary.withValues(alpha: 0.7)
                              ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      AppImages.lockIcon,
                      width: 60, // Larger icon
                      height: 60,
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  )
                      .animate()
                      .scale(
                        begin: Offset(0.7, 0.7),
                        duration: 800.ms,
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(duration: 900.ms),

                  const SizedBox(height: 40),

                  Text(
                    'welcome back in app title'.tr,
                    style: AppTextStyle.titleStyle.copyWith(
                      fontSize: 32, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .slideY(
                        begin: 0.2,
                        duration: 600.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fadeIn(duration: 700.ms),

                  const SizedBox(height: 10),

                  // Welcome content with animation
                  Text(
                    'welcome back in app content'.tr,
                    style: AppTextStyle.contentStyle.copyWith(
                      fontSize: 16, // Slightly larger content font
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .slideY(
                        begin: 0.2,
                        duration: 600.ms,
                        delay: 100.ms,
                        curve: Curves.easeOutCubic,
                      )
                      .fadeIn(duration: 700.ms),

                  const SizedBox(height: 40), // Spacing

                  
                  CustomTextFormFieldWidget(
                    validator: (val) {
                      return inputValidation(100, 5, val!, 'email');
                    },
                    hintText: 'email'.tr,
                    prefixIcon: Iconsax.sms, // Modern icon
                    controller: controller.emailController,
                    
                  )
                      .animate()
                      .slideX(
                        begin: -0.1,
                        duration: 500.ms,
                        delay: 200.ms,
                      )
                      .fadeIn(duration: 600.ms),

                  const SizedBox(height: 20), // Spacing

                  
                  GetBuilder<SignInControllerImp>(
                    builder: (myController) {
                      return CustomTextFormFieldWidget(
                        hintText: 'password'.tr,
                        validator: (val) {
                          return inputValidation(100, 7, val!, 'password');
                        },
                        controller: controller.passwordController,
                        prefixIcon: myController
                            .visibilityIcon, // Use controller's icon
                        obscureText: myController.obscureText,
                        onTapPrefixIcon: myController.showPassword,
                        maxLine: 1,
                      )
                          .animate()
                          .slideX(
                            begin: 0.1,
                            duration: 500.ms,
                            delay: 300.ms,
                          )
                          .fadeIn(duration: 600.ms);
                    },
                  ),

                  const SizedBox(height: 15),

                  
                  GestureDetector(
                    onTap: controller.goToForgetPassword,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'forgot password'.tr,
                        style: TextStyle(
                          fontSize:
                              AppFontsSize.smallFontSize, // Adjusted font size
                          color: AppColors
                              .primary, // Use primary color for emphasis
                          fontWeight: FontWeight.w600, // Make it bolder
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .slideY(
                        begin: 0.2,
                        duration: 500.ms,
                        delay: 400.ms,
                      )
                      .fadeIn(duration: 600.ms),

                  const SizedBox(height: 30),

                  
                  GetBuilder<SignInControllerImp>(builder: (myController) {
                    return CustomButtonWithShadow(
                      buttonText: 'sign in button'.tr,
                      buttonColor: AppColors.primary,
                      onTap: myController.signIn,
                      isCustomChild: myController.isLoading,
                      customChild: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        .animate()
                        .scale(
                          begin: Offset(0.9, 0.9),
                          duration: 600.ms,
                          curve: Curves.easeOutBack,
                        )
                        .fadeIn(duration: 700.ms);
                  }),

                  const SizedBox(height: 30), // Increased spacing

                  // "Or" separator with lines
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color:
                              isDarkMode ? Colors.grey[700] : Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or'.tr,
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color:
                              isDarkMode ? Colors.grey[700] : Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),

                  const SizedBox(height: 30), // Increased spacing

                  // Social sign-in buttons with enhanced design and animation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Handle Google sign-in
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12), // Adjusted padding
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(15), // More rounded
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.grey[700]!
                                    : Colors.grey[300]!,
                                width: 1.5,
                              ),
                              color:
                                  isDarkMode ? Colors.grey[900] : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                      alpha: isDarkMode ? 0.1 : 0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(AppImages.google,
                                width: 30, height: 30), // Adjusted size
                          ),
                        ),
                      ),
                      const SizedBox(width: 20), // Increased spacing
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12), // Adjusted padding
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(15), // More rounded
                              border: Border.all(
                                color: isDarkMode
                                    ? Colors.grey[700]!
                                    : Colors.grey[300]!,
                                width: 1.5,
                              ),
                              color:
                                  isDarkMode ? Colors.grey[900] : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                      alpha: isDarkMode ? 0.1 : 0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(AppImages.facebook,
                                width: 30, height: 30), // Adjusted size
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .slideY(
                        begin: 0.2,
                        duration: 600.ms,
                        delay: 900.ms,
                      )
                      .fadeIn(duration: 700.ms),

                  const SizedBox(height: 20),

                  // Sign up prompt with animation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'haven\'t account'.tr,
                        style: TextStyle(
                          fontSize:
                              AppFontsSize.smallFontSize, // Adjusted font size
                          color: isDarkMode
                              ? Colors.grey[400]
                              : AppColors.customGrey,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: controller.goToSignUp,
                        child: Text(
                          'sign up button'.tr,
                          style: TextStyle(
                            fontSize: AppFontsSize.smallFontSize +
                                1, // Slightly larger
                            fontWeight: FontWeight.w700, // Bolder
                            color:
                                AppColors.primary, // Primary color for emphasis
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .slideY(
                        begin: 0.2,
                        duration: 600.ms,
                        delay: 1000.ms,
                      )
                      .fadeIn(duration: 700.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
