import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class FinancialContributionToReceptionView extends StatelessWidget {
  const FinancialContributionToReceptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    const Color accentColor = Colors.amber;
    const Color highlightColor = Color(0xFF00BFA5);
    const Color warningColor = Color(0xFFD32F2F);

    return Scaffold(
      appBar: CustomAppBar(title: 'financial_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟢 Section 1: Right to Work
            BuildModernCard(
              icon: Icons.work_outline,
              iconColor: highlightColor,
              title: 'work_right_title'.tr,
              items: [
                'work_right_item_1'.tr,
                'work_right_item_2'.tr,
              ],
              footerText: 'work_right_footer'.tr,
              borderColor: highlightColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // 💰 Section 2: Financial Contribution
            BuildModernCard(
              icon: Icons.account_balance_wallet_outlined,
              iconColor: accentColor,
              title: 'contribution_title'.tr,
              items: [
                'contribution_item_1'.tr,
                'contribution_item_2'.tr,
              ],
              footerText: 'contribution_footer'.tr,
              borderColor: accentColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),

            const SizedBox(height: 24),

            // ⚠️ Section 3: Termination of Services
            BuildModernCard(
              icon: Icons.warning_amber_rounded,
              iconColor: warningColor,
              title: 'termination_title'.tr,
              items: [
                'termination_item_1'.tr,
              ],
              footerText: 'termination_footer'.tr,
              borderColor: warningColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),

            const SizedBox(height: 40),

            // 📝 Bottom Reminder
            Center(
              child: Text(
                'financial_footer'.tr,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[isDarkMode ? 400 : 600],
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
