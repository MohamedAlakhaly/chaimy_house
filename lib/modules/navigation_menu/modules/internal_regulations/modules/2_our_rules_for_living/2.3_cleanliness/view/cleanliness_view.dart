import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class CleanlinessView extends StatelessWidget {
  const CleanlinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'cleanliness_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BuildModernCard(
              icon: Icons.cleaning_services,
              iconColor: const Color(0xFF4CAF50), // Green for cleanliness
              title: 'hygiene_section_title'.tr,
              items: [
                'hygiene_item_1'.tr,
                'hygiene_item_2'.tr,
                'hygiene_item_3'.tr,
              ],
              footerText: 'hygiene_footer'.tr,
              borderColor: const Color(0xFF4CAF50),
              isDarkMode: isDarkMode,
            )
                .animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
