import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class AppealingMedicalAssistanceDecisionsView extends StatelessWidget {
  const AppealingMedicalAssistanceDecisionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    const Color primaryColor = Colors.purpleAccent;
    const Color appealColor = Color(0xFF00B8D4);
    const Color timeLimitColor = Color(0xFFD32F2F);

    return Scaffold(
      appBar: CustomAppBar(title: 'appeal_medical_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BuildModernCard(
              icon: Icons.local_hospital_outlined,
              iconColor: appealColor,
              title: 'appeal_medical_right_title'.tr,
              borderColor: appealColor,
              isDarkMode: isDarkMode,
              items: [
                'appeal_medical_intro'.tr,
              ],
              footerText: 'appeal_medical_footer'.tr,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),
            const SizedBox(height: 20),
            BuildModernCard(
              icon: Icons.schedule_outlined,
              iconColor: timeLimitColor,
              title: 'appeal_medical_procedure_title'.tr,
              borderColor: timeLimitColor,
              isDarkMode: isDarkMode,
              items: [
                'appeal_medical_procedure_details'.tr,
                'appeal_medical_response_details'.tr,
              ],
              footerText: 'appeal_medical_procedure_footer'.tr,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 20),
            BuildModernCard(
              icon: Icons.info_outline,
              iconColor: primaryColor,
              title: 'appeal_medical_final_title'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
              items: ['appeal_medical_final_note'.tr],
              footerText: 'appeal_medical_support_footer'.tr,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
            const SizedBox(height: 16),
            Text(
              'appeal_medical_closing_note'.tr,
              style: TextStyle(
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                color: Colors.grey[isDarkMode ? 400 : 600],
              ),
              textAlign: TextAlign.center,
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
