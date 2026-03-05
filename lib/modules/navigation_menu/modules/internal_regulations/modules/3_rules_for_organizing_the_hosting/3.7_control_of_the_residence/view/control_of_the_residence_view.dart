import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/cards/custom_section_internal_regulations.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ControlOfTheResidenceView extends StatelessWidget {
  const ControlOfTheResidenceView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.amber;
    const Color safetyColor = Color(0xFF1976D2);
    const Color warningColor = Color(0xFFD32F2F);
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'control_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Regular Checks
            BuildModernCard(
              icon: Icons.security,
              iconColor: safetyColor,
              title: 'control_regular_checks_title'.tr,
              items: [
                'control_regular_checks_details'.tr,
                'control_check_frequency'.tr,
              ],
              footerText: 'control_regular_checks_footer'.tr,
              borderColor: safetyColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),
            const SizedBox(height: 20),

            // Unscheduled Checks
            CustomSectionForInternalRegulations(
              icon: Icons.warning,
              title: 'control_unscheduled_checks_title'.tr,
              description: 'control_unscheduled_checks_details'.tr,
              mainColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 20),

            // During a Check
            BuildModernCard(
              icon: Icons.person_search,
              iconColor: Colors.cyan,
              title: 'control_during_check_title'.tr,
              items: [
                'control_during_check_details'.tr,
                'control_prohibited_items'.tr,
                'control_dangerous_items'.tr,
              ],
              footerText: 'control_during_check_footer'.tr,
              borderColor: Colors.cyan,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
            const SizedBox(height: 20),

            // Confiscated Items
            BuildModernCard(
              icon: Icons.folder,
              iconColor: warningColor,
              title: 'control_confiscated_items_title'.tr,
              items: [
                'control_item_return'.tr,
                'control_item_confiscation'.tr,
              ],
              footerText: 'control_confiscated_items_footer'.tr,
              borderColor: warningColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),

            const SizedBox(height: 30),

            // Footer
            Center(
              child: Text(
                'control_footer_text_general'.tr,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[isDarkMode ? 400 : 600],
                ),
                textAlign: TextAlign.center,
              ),
            ).animate()
                .slideY(begin: 0.3, duration: 1000.ms, curve: Curves.easeOut)
                .fadeIn(delay: 1000.ms),
          ],
        ),
      ),
    );
  }
}
