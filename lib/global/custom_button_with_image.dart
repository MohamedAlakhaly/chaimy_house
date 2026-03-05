
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';

class CustomButtonWithImage extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final String imagePath;
  const CustomButtonWithImage({
    super.key,
    this.onTap,
    required this.buttonText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imagePath,
              height: 30,
            ),
            const SizedBox(width: 15),
            Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppFontsSize.smallFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
