import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PocketMoneyView extends StatelessWidget {
  const PocketMoneyView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'pocket_money_appbar_title'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.teal.shade400, Colors.teal.shade600],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha:0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'pocket_money_header_title'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'pocket_money_header_desc'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha:0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'pocket_money_paid_day'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.9, 0.9),
                  duration: 600.ms,
                  curve: Curves.easeOut,
                )
                .fadeIn(duration: 400.ms),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildModernCard(
                    icon: Icons.shopping_cart_rounded,
                    iconColor: Colors.red.shade600,
                    isDarkMode: isDarkMode,
                    title: 'pocket_money_pay_with_title'.tr,
                    items: [
                      'pocket_money_pay_with_item_1'.tr,
                      'pocket_money_pay_with_item_2'.tr,
                      'pocket_money_pay_with_item_3'.tr,
                    ],
                    footerText: 'pocket_money_pay_with_footer'.tr,
                    borderColor: Colors.red.shade200,
                  )
                      .animate()
                      .slideX(
                        begin: -0.2,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(delay: 200.ms),

                  const SizedBox(height: 16),

                  _buildModernCard(
                    icon: Icons.verified_rounded,
                    iconColor: Colors.green.shade600,
                    isDarkMode: isDarkMode,
                    title: 'pocket_money_not_pay_title'.tr,
                    items: [
                      'pocket_money_not_pay_item_1'.tr,
                      'pocket_money_not_pay_item_2'.tr,
                      'pocket_money_not_pay_item_3'.tr,
                      'pocket_money_not_pay_item_4'.tr,
                    ],
                    footerText: 'pocket_money_not_pay_footer'.tr,
                    borderColor: Colors.green.shade200,
                  )
                      .animate()
                      .slideX(
                        begin: 0.2,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(delay: 400.ms),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 900 : 100],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.2),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.add_circle_rounded,
                                color: Colors.red.shade600,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'pocket_money_community_services_title'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'pocket_money_community_services_desc'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.grey[isDarkMode ? 300 : 700],
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .slideX(
                        begin: -0.2,
                        duration: 500.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(delay: 600.ms),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<String> items,
    required String footerText,
    required Color borderColor,
    required bool isDarkMode,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[isDarkMode ? 900 : 100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withValues(alpha: 0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.grey[isDarkMode ? 300 : 700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: iconColor, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    footerText,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
