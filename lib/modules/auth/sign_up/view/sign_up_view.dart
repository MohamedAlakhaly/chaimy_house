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
import 'package:chimay_house/core/functions/social_method.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/modules/auth/sign_up/controller/sign_up_controller.getx.dart';
import 'package:chimay_house/modules/auth/sign_up/widget/custom_disable_button_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    SignUpControllerImp controller = Get.put(SignUpControllerImp());
    SocialAuthImp socialAuthImp = SocialAuthImp();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              25,
            ), // Increased padding to match sign-in
            child: Form(
              key: controller.globalKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Added center alignment
                children: [
                  const SizedBox(height: 20), // Reduced height to match sign-in

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
                                    AppColors.primary.withValues(alpha: 0.5),
                                  ]
                                : [
                                    AppColors.primary.withValues(alpha: 0.9),
                                    AppColors.primary.withValues(alpha: 0.7),
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
                          AppImages.peopleIcon,
                          width: 60, // Larger icon size
                          height: 60,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                      .animate()
                      .scale(
                        begin: Offset(0.7, 0.7),
                        duration: 800.ms,
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(duration: 900.ms),

                  const SizedBox(height: 40), // Increased spacing

                  Text(
                        'create new account title'.tr,
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

                  Text(
                        'create new account content'.tr,
                        style: AppTextStyle.contentStyle.copyWith(
                          fontSize: 16, // Slightly larger content font
                          color: isDarkMode
                              ? Colors.grey[300]
                              : Colors.grey[700],
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

                  const SizedBox(height: 40), // Increased spacing
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

                  CustomTextFormFieldWidget(
                        controller: controller.usernameController,
                        hintText: 'username'.tr,
                        prefixIcon: Iconsax.user, // Modern Iconsax icon
                        validator: (val) {
                          return inputValidation(20, 1, val!, 'name');
                        },
                      )
                      .animate()
                      .slideX(begin: -0.1, duration: 500.ms, delay: 200.ms)
                      .fadeIn(duration: 600.ms),

                  const SizedBox(height: 20),

                  CustomTextFormFieldWidget(
                        controller: controller.emailController,
                        hintText: 'email'.tr,
                        prefixIcon: Iconsax.sms, // Modern Iconsax icon
                        validator: (val) {
                          return inputValidation(50, 1, val!, 'email');
                        },
                      )
                      .animate()
                      .slideX(begin: 0.1, duration: 500.ms, delay: 300.ms)
                      .fadeIn(duration: 600.ms),

                  const SizedBox(height: 20), // Increased spacing

                  GetBuilder<SignUpControllerImp>(
                    builder: (myController) {
                      return CustomTextFormFieldWidget(
                            controller: controller.passwordController,
                            hintText: 'password'.tr,
                            validator: (val) {
                              return inputValidation(20, 1, val!, 'password');
                            },
                            prefixIcon: controller.visibilityIcon,
                            obscureText: controller.obscureText,
                            onTapPrefixIcon: controller.showPassword,
                            maxLine: 1,
                          )
                          .animate()
                          .slideX(begin: -0.1, duration: 500.ms, delay: 400.ms)
                          .fadeIn(duration: 600.ms);
                    },
                  ),

                  const SizedBox(height: 20), // Increased spacing

                  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GetBuilder<SignUpControllerImp>(
                            builder: (myController) {
                              return Checkbox(
                                activeColor: AppColors.primary,
                                value: controller.agreePrivate,
                                onChanged: (val) {
                                  controller.agreePrivate = val!;
                                  controller.update();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              );
                            },
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
                          ),
                        ],
                      )
                      .animate()
                      .slideY(begin: 0.2, duration: 500.ms, delay: 500.ms)
                      .fadeIn(duration: 600.ms),

                  const SizedBox(height: 30), // Increased spacing

                  GetBuilder<SignUpControllerImp>(
                    builder: (myController) {
                      return CustomDisableButtonWidget(
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
                              controller.signUp();
                            },
                          )
                          .animate()
                          .scale(
                            begin: Offset(0.9, 0.9),
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                          .fadeIn(duration: 700.ms);
                    },
                  ),

                  const SizedBox(height: 30), // Increased spacing

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDarkMode
                              ? Colors.grey[700]
                              : Colors.grey[300],
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
                          color: isDarkMode
                              ? Colors.grey[700]
                              : Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 600.ms, delay: 800.ms),

                  const SizedBox(height: 30), // Increased spacing

                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: controller.signInWithGoogle,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ), // Adjusted padding
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ), // More rounded
                                  border: Border.all(
                                    color: isDarkMode
                                        ? Colors.grey[700]!
                                        : Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                  color: isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: isDarkMode ? 0.1 : 0.05,
                                      ),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  AppImages.google,
                                  width: 30,
                                  height: 30,
                                ), // Adjusted size
                              ),
                            ),
                          ),
                          const SizedBox(width: 20), // Increased spacing
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ), // Adjusted padding
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ), // More rounded
                                  border: Border.all(
                                    color: isDarkMode
                                        ? Colors.grey[700]!
                                        : Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                  color: isDarkMode
                                      ? Colors.grey[900]
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: isDarkMode ? 0.1 : 0.05,
                                      ),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  AppImages.facebook,
                                  width: 30,
                                  height: 30,
                                ), // Adjusted size
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .slideY(begin: 0.2, duration: 600.ms, delay: 900.ms)
                      .fadeIn(duration: 700.ms),

                  const SizedBox(height: 20),

                  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'have account'.tr,
                            style: TextStyle(
                              fontSize: AppFontsSize
                                  .smallFontSize, // Adjusted font size
                              color: isDarkMode
                                  ? Colors.grey[400]
                                  : AppColors.customGrey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: controller.goToSignIn,
                            child: Text(
                              'sign in button'.tr,
                              style: TextStyle(
                                fontSize:
                                    AppFontsSize.smallFontSize +
                                    1, // Slightly larger
                                fontWeight: FontWeight.w700, // Bolder
                                color: AppColors
                                    .primary, // Primary color for emphasis
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .slideY(begin: 0.2, duration: 600.ms, delay: 1000.ms)
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
