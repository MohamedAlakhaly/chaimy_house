import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class DepositSystemView extends StatelessWidget {
  const DepositSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color depositColor = Colors.cyan;
    const Color attentionColor = Colors.amber;
    const double spacing = 25.0;

    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(title: 'deposit_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildModernCard(
              icon: Icons.lock_open,
              iconColor: depositColor,
              title: 'deposit_material_title'.tr,
              items: ['deposit_material_text'.tr],
              footerText: 'deposit_material_footer'.tr,
              borderColor: depositColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: spacing),

            BuildModernCard(
              icon: Icons.settings_backup_restore,
              iconColor: attentionColor,
              title: 'deposit_return_title'.tr,
              items: ['deposit_return_text'.tr],
              footerText: 'deposit_return_footer'.tr,
              borderColor: attentionColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}
