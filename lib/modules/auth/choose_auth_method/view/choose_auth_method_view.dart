import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/modules/auth/choose_auth_method/controller/choose_auth_method_controller.getx.dart';

class ChooseAuthMethodView extends StatelessWidget {
  const ChooseAuthMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    ChooseAuthMethodControllerImp controller =Get.put(ChooseAuthMethodControllerImp());
  bool isDarkMode =HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity,height: 20),
                SvgPicture.asset(
                  AppImages.welcome,
                  height: 370,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'welcome in app title'.tr,
                          style: const TextStyle(
                              fontSize: AppFontsSize.extraLargeFontSize + 3)),
                      TextSpan(
                          text: ' ILA',
                          style: TextStyle(
                              fontSize: AppFontsSize.extraLargeFontSize + 3,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary)),
                    ],
                  ),
                ),
                Text(
                  'welcome in app content'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.customGrey,
                    fontSize: AppFontsSize.extraSmallFontSize,
                  ),
                ),
                const SizedBox(height: 50),
                CustomButtonWithShadow(
                  buttonText: 'get started button'.tr,
                  buttonColor: AppColors.primary,
                  onTap: controller.goToSignUp,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 10),
                CustomButtonWithShadow(
                  textColor: isDarkMode ? Colors.black : Colors.white,
                  buttonText: 'already have an account button'.tr,
                  buttonColor:isDarkMode? AppColors.bgLight:AppColors.bgDark,
                  onTap: controller.goToSignIn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
