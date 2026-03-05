import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:chimay_house/core/constant/app_colors.dart';

class CustomPercentButtonOnBoarding extends StatelessWidget {
  final void Function()? onTapButton;
  final double percent;
  const CustomPercentButtonOnBoarding({
    super.key,
    this.onTapButton,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {

    //! This widget for add CircularPercentIndicator to on-boarding page
    return CircularPercentIndicator(
      percent: percent,
      radius: 35,
      animation: true,
      animateFromLastPercent: true,
      progressColor: AppColors.primary,
      backgroundColor:AppColors.primary.withValues(alpha:0.3),
      addAutomaticKeepAlive: true,
      lineWidth: 2,
      center: GestureDetector(
        onTap: onTapButton,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.primary, shape: BoxShape.circle),
          child: const Icon(Icons.arrow_forward_outlined),
        ),
      ),
    );
  }
}
