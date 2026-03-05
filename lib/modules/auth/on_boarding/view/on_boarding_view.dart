import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/modules/auth/on_boarding/controller/on_boarding_controller.getx.dart';
import 'package:chimay_house/modules/auth/on_boarding/widget/custom_percent_button_on_boarding.dart';
import 'package:chimay_house/modules/auth/on_boarding/widget/on_boarding_page_view_widget.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingControllerImp controller = Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //! This section for add page view with photos and title and subtitle
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: OnBoardingPageViewWidget(),
              ),
          
              //! This section for add custom percent button
              Padding(
                padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:controller.skipButton,
                      child: Text('skip button'.tr,
                          style: const TextStyle(
                              fontSize: AppFontsSize.smallFontSize,
                              fontWeight: FontWeight.w600)),
                    ),
                    GetBuilder<OnBoardingControllerImp>(
                        builder: (myController) {
                      return CustomPercentButtonOnBoarding(
                        percent: controller.currentPercent,
                        onTapButton: controller.jumpToNextSlide,
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
