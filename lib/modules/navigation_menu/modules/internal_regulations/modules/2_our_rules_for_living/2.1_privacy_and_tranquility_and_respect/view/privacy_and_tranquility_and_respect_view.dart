import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PrivacyAndTranquilityAndRespectView extends StatelessWidget {
  const PrivacyAndTranquilityAndRespectView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'privacy_page_title'.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BuildModernCard(
              icon: Icons.people_alt_outlined,
              iconColor: Colors.blue,
              title: 'privacy_section_title'.tr,
              items: [
                'privacy_item_1'.tr,
                'privacy_item_2'.tr,
                'privacy_item_3'.tr,
                'privacy_item_4'.tr,
                'privacy_item_5'.tr,
              ],
              footerText: 'privacy_footer'.tr,
              borderColor: Colors.blue,
              isDarkMode: isDarkMode,
            )
                .animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.home_work_outlined,
              iconColor: Colors.teal,
              title: 'accommodation_section_title'.tr,
              items: [
                'accommodation_item_1'.tr,
                'accommodation_item_2'.tr,
                'accommodation_item_3'.tr,
                'accommodation_item_4'.tr,
                'accommodation_item_5'.tr,
                'accommodation_item_6'.tr,
              ],
              footerText: 'accommodation_footer'.tr,
              borderColor: Colors.teal,
              isDarkMode: isDarkMode,
            )
                .animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),

            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.flash_on,
              iconColor: Colors.orange,
              title: 'utilities_section_title'.tr,
              items: [
                'utilities_item_1'.tr,
                'utilities_item_2'.tr,
                'utilities_item_3'.tr,
                'utilities_item_4'.tr,
                'utilities_item_5'.tr,
              ],
              footerText: 'utilities_footer'.tr,
              borderColor: Colors.orange,
              isDarkMode: isDarkMode,
            )
                .animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),

            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.cleaning_services_outlined,
              iconColor: Colors.indigo,
              title: 'maintenance_section_title'.tr,
              items: [
                'maintenance_item_1'.tr,
                'maintenance_item_2'.tr,
                'maintenance_item_3'.tr,
                'maintenance_item_4'.tr,
                'maintenance_item_5'.tr,
              ],
              footerText: 'maintenance_footer'.tr,
              borderColor: Colors.indigo,
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.security,
              iconColor: Colors.red,
              title: 'security_section_title'.tr,
              items: [
                'security_item_1'.tr,
                'security_item_2'.tr,
                'security_item_3'.tr,
              ],
              footerText: 'security_footer'.tr,
              borderColor: Colors.red,
              isDarkMode: isDarkMode,
            )
                .animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
