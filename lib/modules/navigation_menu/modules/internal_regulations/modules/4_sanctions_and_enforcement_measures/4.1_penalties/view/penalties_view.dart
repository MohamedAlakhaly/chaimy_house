import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/cards/custom_section_internal_regulations.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PenaltiesView extends StatelessWidget {
  const PenaltiesView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1565C0);
    const Color sanctionColor = Color(0xFFD32F2F);
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'penalties_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction Card
            BuildModernCard(
              icon: Icons.info_outline,
              iconColor: primaryColor,
              title: 'penalties_intro_title'.tr,
              items: [
                'penalties_intro_paragraph1'.tr,
                'penalties_intro_paragraph2'.tr
              ],
              footerText: 'penalties_intro_footer'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),
            const SizedBox(height: 20),

            // Possible Sanctions Card
            BuildModernCard(
              icon: Icons.gavel,
              iconColor: sanctionColor,
              title: 'penalties_possible_title'.tr,
              items: [
                'penalties_list_item1'.tr,
                'penalties_list_item2'.tr,
                'penalties_list_item3'.tr,
                'penalties_list_item4'.tr,
                'penalties_list_item5'.tr,
                'penalties_list_item6'.tr,
                'penalties_list_item7'.tr,
                'penalties_list_item8'.tr,
                'penalties_list_item9'.tr,
              ],
              footerText: 'penalties_possible_footer'.tr,
              borderColor: sanctionColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 20),

            // Execution & Appeal Section
            CustomSectionForInternalRegulations(
              icon: Icons.assignment_turned_in,
              title: 'penalties_execution_title'.tr,
              description:
                  '${'penalties_execution_start'.tr}\n\n${'penalties_execution_end'.tr}',
              mainColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
            const SizedBox(height: 25),

            // Contact Info (Footer)
            BuildModernCard(
              icon: Icons.contact_support,
              iconColor: primaryColor,
              title: 'penalties_contact_title'.tr,
              items: ['penalties_contact_details'.tr],
              footerText: 'penalties_contact_footer'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),

            const SizedBox(height: 30),
            Center(
              child: Text(
                'penalties_footer_text'.tr,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
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
