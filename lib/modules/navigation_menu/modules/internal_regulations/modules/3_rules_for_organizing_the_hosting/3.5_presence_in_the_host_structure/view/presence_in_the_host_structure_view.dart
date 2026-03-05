import 'package:chimay_house/global/cards/custom_section_internal_regulations.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PresenceInTheHostStructureView extends StatelessWidget {
  const PresenceInTheHostStructureView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.amber;
    const Color warningColor = Color(0xFFD32F2F);
    const Color attentionColor = Colors.cyan;
    const double spacing = 25.0;

    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'presence_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Rule
            BuildModernCard(
              icon: Icons.home,
              iconColor: primaryColor,
              title: 'presence_main_rule_title'.tr,
              items: ['presence_main_rule_text'.tr],
              footerText: 'presence_main_rule_footer'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: spacing),

            // Night Absence Rule
            BuildModernCard(
              icon: Icons.hotel,
              iconColor: warningColor,
              title: 'night_absence_title'.tr,
              items: ['night_absence_text'.tr],
              footerText: 'night_absence_footer'.tr,
              borderColor: warningColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),

            const SizedBox(height: spacing),

            // Long Absence Rule
            BuildModernCard(
              icon: Icons.calendar_today,
              iconColor: attentionColor,
              title: 'long_absence_title'.tr,
              items: [
                'long_absence_text'.tr,
                'long_absence_additional'.tr
              ],
              footerText: 'long_absence_footer'.tr,
              borderColor: attentionColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),

            const SizedBox(height: spacing),

            // Reapplying
            CustomSectionForInternalRegulations(
              icon: Icons.assignment_turned_in,
              title: 'reapply_title'.tr,
              description: 'reapply_text'.tr,
              mainColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),

            const SizedBox(height: spacing),

            // Footer
            Center(
              child: Text(
                'presence_footer'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[isDarkMode ? 400 : 600],
                ),
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
