import 'package:chimay_house/global/cards/custom_section_internal_regulations.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ExercisingParentalAuthorityView extends StatelessWidget {
  const ExercisingParentalAuthorityView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.cyan;
    const Color supportColor = Colors.amber;
    const double spacing = 25.0;

    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'parental_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===========================================
            // 1. Majority Rule
            // ===========================================
            BuildModernCard(
              icon: Icons.cake,
              iconColor: primaryColor,
              title: 'majority_rule_title'.tr,
              items: ['majority_rule_text'.tr],
              footerText: 'majority_rule_footer'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: spacing),

            // ===========================================
            // 2. Parental Responsibility
            // ===========================================
            CustomSectionForInternalRegulations(
              icon: Icons.family_restroom,
              title: 'parental_responsibilities_title'.tr,
              description: 'parental_responsibilities_text'.tr,
              mainColor: supportColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),

            const SizedBox(height: spacing),

            // ===========================================
            // Footer Message
            // ===========================================
            Center(
              child: Text(
                'parental_footer'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[isDarkMode ? 400 : 600],
                ),
              ),
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
