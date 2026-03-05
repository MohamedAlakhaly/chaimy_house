import 'package:flutter/material.dart';
import 'package:chimay_house/core/constant/app_colors.dart';

class AppTextStyle {
  static TextStyle titleStyle = const TextStyle(
      fontSize: AppFontsSize.extraLargeFontSize, fontWeight: FontWeight.w800);

  static TextStyle contentStyle = TextStyle(
      fontSize: AppFontsSize.extraSmallFontSize, color: AppColors.customGrey);
}
