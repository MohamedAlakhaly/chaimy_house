import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class AppealingAPenaltyImposedView extends StatelessWidget {
  const AppealingAPenaltyImposedView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1565C0);
    const Color appealColor = Color(0xFF0288D1);
    const Color warningColor = Color(0xFFE65100);
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'appeal_penalty_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Right to Revision Appeal
            BuildModernCard(
              icon: Icons.assignment_turned_in_rounded,
              iconColor: appealColor,
              title: 'appeal_penalty_right_title'.tr,
              items: [
                'appeal_penalty_intro'.tr,
                'appeal_penalty_recipients'.tr,
                'appeal_penalty_general_director'.tr,
                'appeal_penalty_designated_person'.tr,
                'appeal_penalty_council'.tr,
              ],
              footerText: 'appeal_penalty_footer'.tr,
              borderColor: appealColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),
            const SizedBox(height: 20),

            // Procedure Rules & Deadlines
            BuildModernCard(
              icon: Icons.schedule_rounded,
              iconColor: Colors.red.shade600,
              title: 'appeal_penalty_procedure_title'.tr,
              items: ['appeal_penalty_procedure_details'.tr],
              footerText: 'appeal_penalty_procedure_footer'.tr,
              borderColor: Colors.red.shade600,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 20),

            // Response & Maintenance
            BuildModernCard(
              icon: Icons.info_rounded,
              iconColor: warningColor,
              title: 'appeal_penalty_response_title'.tr,
              items: ['appeal_penalty_response_details'.tr],
              footerText: 'appeal_penalty_response_footer'.tr,
              borderColor: warningColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
            const SizedBox(height: 30),

            // Footer
            Center(
              child: Text(
                'appeal_penalty_final_footer'.tr,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
