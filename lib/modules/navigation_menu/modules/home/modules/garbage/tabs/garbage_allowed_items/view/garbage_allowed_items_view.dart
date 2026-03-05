import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class GarbageAllowedItemsView extends StatelessWidget {
  const GarbageAllowedItemsView({super.key});

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

            /// Food waste
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.green,
              icon: Icons.restaurant,
              title: 'foodWasteTitle'.tr,
              delay: 400,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.green,
                child: _buildCheckItem(
                  text: 'foodWasteContent'.tr,
                  color: Colors.green.shade700,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Paper products
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.blue,
              icon: Icons.description_outlined,
              title: 'paperProductsTitle'.tr,
              delay: 600,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.blue,
                child: Column(
                  children: [
                    _buildCheckItem(
                      text: 'paperProductsContent1'.tr,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildCheckItem(
                      text: 'paperProductsContent2'.tr,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildCheckItem(
                      text: 'paperProductsContent3'.tr,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Plastic items
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.red,
              icon: Icons.local_drink_outlined,
              title: 'plasticItemsTitle'.tr,
              delay: 800,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.red,
                child: _buildCheckItem(
                  text: 'plasticItemsDescription'.tr,
                  color: Colors.red,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Important note
            _buildSectionCard(
              isDarkMode: isDarkMode,
              color: Colors.orange,
              icon: Icons.info_outline,
              title: 'importantNoteTitle'.tr,
              delay: 1000,
              content: _buildInfoBox(
                isDarkMode: isDarkMode,
                color: Colors.orange,
                icon: Icons.lightbulb_outline,
                child: Text(
                  'importantNoteDescription'.tr,
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
          'assets/images/category/garbage/allowed_items.jpg',
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

  Widget _buildCheckItem({
    required String text,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 15)),
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
        mainAxisSize: MainAxisSize.min,
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
          Text(
            'keepYourEnvironmentClean'.tr,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: 1200.ms, duration: 500.ms)
        .slideY(begin: 0.2);
  }
}
