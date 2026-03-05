import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'security_page_title'.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BuildModernCard(
              icon: Icons.local_fire_department,
              iconColor: Colors.red,
              title: 'fire_section_title'.tr,
              items: [
                'fire_rule_1'.tr,
                'fire_rule_2'.tr,
                'fire_rule_3'.tr,
                'fire_rule_4'.tr,
                'fire_rule_5'.tr,
                'fire_rule_6'.tr,
              ],
              footerText: 'fire_footer'.tr,
              borderColor: Colors.red,
              isDarkMode: isDarkMode,
            )
                .animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.block,
              iconColor: Colors.orange,
              title: 'prohibitions_section_title'.tr,
              items: [
                'prohibition_item_1'.tr,
                'prohibition_item_2'.tr,
                'prohibition_item_3'.tr,
                'prohibition_item_4'.tr,
                'prohibition_item_5'.tr,
                'prohibition_item_6'.tr,
                'prohibition_item_7'.tr,
                'prohibition_item_8'.tr,
              ],
              footerText: 'prohibitions_footer'.tr,
              borderColor: Colors.orange,
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
