import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/modules/auth/waiting_for_activation/controller/waiting_for_activation_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WaitingForActivationView extends StatelessWidget {
  const WaitingForActivationView({super.key});

  @override
  Widget build(BuildContext context) {
    WaitingForActivationControllerImp controller = Get.put(
      WaitingForActivationControllerImp(),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<WaitingForActivationControllerImp>(
          builder: (myController) {
            return controller.isLoading == false
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 70),
                        SvgPicture.asset(
                          AppImages.waitingForActivation,
                          height: 350,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'waitingForActivationTitle'.tr,
                          style: AppTextStyle.titleStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'waitingForActivationContent'.tr,
                          style: AppTextStyle.contentStyle,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 40),

                        CustomButtonWithShadow(
                          buttonText: 'retryButton'.tr,
                          buttonColor: AppColors.primary,
                          onTap: controller.checkUser,
                        ),
                      ],
                    ),
                  )
                : CustomLoadingCircular();
          },
        ),
      ),
    );
  }
}
