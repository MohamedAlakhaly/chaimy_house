import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class OrderOfMeasuresView extends StatelessWidget {
  const OrderOfMeasuresView({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1565C0);
    const Color orderColor = Colors.cyan;
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'order_measures_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Purpose and Due Process
            BuildModernCard(
              icon: Icons.balance,
              iconColor: orderColor,
              title: 'order_measures_purpose_title'.tr,
              items: ['order_measures_purpose_details'.tr],
              footerText: 'order_measures_purpose_footer'.tr,
              borderColor: orderColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),
            const SizedBox(height: 20),

            // Communication of Measures
            BuildModernCard(
              icon: Icons.campaign_outlined,
              iconColor: primaryColor,
              title: 'order_measures_communication_title'.tr,
              items: ['order_measures_communication_details'.tr],
              footerText: 'order_measures_communication_footer'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 30),

            // Footer
            Center(
              child: Text(
                'order_measures_footer_text'.tr,
                style: TextStyle(
                  fontSize: 13.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
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
