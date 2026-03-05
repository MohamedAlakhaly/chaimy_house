import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCardProfileScreen extends StatelessWidget {
  final String cartTitle;
  final String cartSubTitle;
  final IconData cardIcon;
  final void Function()? onTap;
  final bool? actionButton;
  const CustomCardProfileScreen({
    super.key,
    required this.cartTitle,
    required this.cartSubTitle,
    required this.cardIcon,
    this.actionButton =false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[isDarkMode ? 900 : 200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(cardIcon, size: 28, color: AppColors.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    cartSubTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[isDarkMode ? 400 : 700],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            if (actionButton ==true)
            Icon(Iconsax.arrow_right_3,color:Colors.grey[isDarkMode ? 400 : 700])
          ],
        ),
      ),
    );
  }
}
