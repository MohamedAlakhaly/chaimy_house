import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ObligationToProvideInformationView extends StatelessWidget {
  const ObligationToProvideInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    const Color accentColor = Colors.amber;
    const Color alertColor = Color(0xFF1565C0);

    return Scaffold(
      appBar: CustomAppBar(title: 'obligation_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📘 Main Card
            BuildModernCard(
              icon: Icons.info_outline,
              iconColor: alertColor,
              title: 'main_rule_title'.tr,
              items: [
                'main_rule_item_1'.tr,
                'main_rule_item_2'.tr,
                'main_rule_item_3'.tr,
              ],
              footerText: 'main_rule_footer'.tr,
              borderColor: alertColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // 💼 Secondary Card
            BuildModernCard(
              icon: Icons.work_outline,
              iconColor: accentColor,
              title: 'employment_rule_title'.tr,
              items: [
                'employment_item_1'.tr,
                'employment_item_2'.tr,
              ],
              footerText: 'employment_footer'.tr,
              borderColor: accentColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),

            const SizedBox(height: 40),

            // 📝 Footer
            Center(
              child: Text(
                'obligation_footer'.tr,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[isDarkMode ? 400 : 600],
                ),
                textAlign: TextAlign.center,
              ),
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
