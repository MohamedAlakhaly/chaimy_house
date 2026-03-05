import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class FilingAComplaintView extends StatelessWidget {
  const FilingAComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1565C0);
    const Color step1Color = Color(0xFF2E7D32);
    const Color step2Color = Color(0xFFC62828);
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'filing_complaint_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Right to Complain
            BuildModernCard(
              icon: Icons.info_rounded,
              iconColor: primaryColor,
              title: 'filing_complaint_your_right_title'.tr,
              items: ['filing_complaint_initial_rule'.tr],
              footerText: 'filing_complaint_footer_text'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),
            const SizedBox(height: 20),

            // Step 1: Reception Structure
            BuildModernCard(
              icon: Icons.comment_bank_rounded,
              iconColor: step1Color,
              title: 'filing_complaint_step1_title'.tr,
              items: [
                'filing_complaint_step1_details'.tr,
                'filing_complaint_step1_note'.tr,
              ],
              footerText: 'filing_complaint_step1_footer'.tr,
              borderColor: step1Color,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 20),

            // Step 2: Escalate to Fedasil
            BuildModernCard(
              icon: Icons.send_rounded,
              iconColor: step2Color,
              title: 'filing_complaint_step2_title'.tr,
              items: [
                'filing_complaint_step2_details'.tr,
                'filing_complaint_fedasil_address'.tr,
              ],
              footerText: 'filing_complaint_step2_footer'.tr,
              borderColor: step2Color,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
            const SizedBox(height: 30),

            // Footer
            Center(
              child: Text(
                'filing_complaint_final_footer'.tr,
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
