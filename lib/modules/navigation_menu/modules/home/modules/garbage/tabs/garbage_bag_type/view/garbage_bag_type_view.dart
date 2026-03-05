import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class GarbageBagTypeView extends StatelessWidget {
  const GarbageBagTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            /// Image
            _buildImageCard(),

            const SizedBox(height: 30),

            /// Required bag type
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.green,
              icon: Icons.check_circle_outline,
              title: 'requiredBagType'.tr,
              delay: 400,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.green,
                icon: Icons.shopping_bag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'requiredBagTypeTitle'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'requiredBagTypeDescription'.tr,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Do not use
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.red,
              icon: Icons.cancel_outlined,
              title: 'garbageDoNotUse'.tr,
              delay: 600,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.red,
                child: Column(
                  children: [
                    _buildCloseItem(
                      text: 'garbageDoNotUseTip1'.tr,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    _buildCloseItem(
                      text: 'garbageDoNotUseTip2'.tr,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    _buildCloseItem(
                      text: 'garbageDoNotUseTip3'.tr,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Helpful tips
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.orange,
              icon: Icons.lightbulb_outline,
              title: 'garbageHelpfulTips'.tr,
              delay: 800,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.orange,
                icon: Icons.info_outline,
                child: Text(
                  'garbageHelpfulTipsContent'.tr,
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Bottom badge
            _buildBottomBadge(),
          ],
        ),
      ),
    );
  }

  // ===================== Widgets =====================

  Widget _buildImageCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/category/garbage/bag_type.jpg',
          fit: BoxFit.cover,
        ),
      ),
    )
        .animate()
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
        .fadeIn(delay: 200.ms);
  }

  Widget _buildSectionCard({
    required bool isDarkMode,
    required MaterialColor color,
    required IconData icon,
    required String title,
    required Widget content,
    required int delay,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.shade600),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha:0.6),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                  color: color.shade600.withValues(alpha:0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color.shade600, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    )
        .animate()
        .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
        .fadeIn(delay: delay.ms);
  }

  Widget _buildInfoBox({
    required bool isDarkMode,
    required MaterialColor color,
    required Widget child,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.shade600),
      ),
      child: icon == null
          ? child
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color.shade600, size: 22),
                const SizedBox(width: 12),
                Expanded(child: child),
              ],
            ),
    );
  }

  Widget _buildCloseItem({
    required String text,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.close, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .fadeIn(duration: 1000.ms)
              .then()
              .fadeOut(duration: 1000.ms),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'keepExtraBagsInStockLable'.tr,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 1000.ms, duration: 500.ms)
        .slideY(begin: 0.2);
  }
}
