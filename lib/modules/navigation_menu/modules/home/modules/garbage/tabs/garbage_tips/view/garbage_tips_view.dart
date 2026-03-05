import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class GarbageTipsView extends StatelessWidget {
  const GarbageTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/category/garbage/CamScanner 09-10-2025 12.00_5.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              )
              .animate()
              .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
              .fadeIn(delay: 200.ms),

          const SizedBox(height: 30),

          _buildTipCard(
            isDarkMode: isDarkMode,
            icon: Icons.shopping_bag_outlined,
            color: Colors.blue,
            title: 'garbageTipsTitle1'.tr,
            description: 'garbageTipsDescription1'.tr,
            delay: 400,
          ),

          const SizedBox(height: 16),

          _buildTipCard(
            isDarkMode: isDarkMode,
            icon: Icons.home_outlined,
            color: Colors.green,
            title: 'garbageTipsTitle2'.tr,
            description: 'garbageTipsDescription2'.tr,
            delay: 600,
          ),

          const SizedBox(height: 16),

          _buildTipCard(
            isDarkMode: isDarkMode,
            icon: Icons.cleaning_services_outlined,
            color: Colors.purple,
            title: 'garbageTipsTitle3'.tr,
            description: 'garbageTipsDescription3'.tr,
            delay: 800,
          ),

          const SizedBox(height: 16),

          _buildTipCard(
            isDarkMode: isDarkMode,
            icon: Icons.air_outlined,
            color: Colors.teal,
            title: 'garbageTipsTitle4'.tr,
            description: 'garbageTipsDescription4'.tr,
            delay: 1000,
          ),

          const SizedBox(height: 16),

          _buildTipCard(
            isDarkMode: isDarkMode,
            icon: Icons.spa_outlined,
            color: Colors.pink,
            title: 'garbageTipsTitle5'.tr,
            description: 'garbageTipsDescription5'.tr,
            delay: 1200,
          ),

          const SizedBox(height: 30),

          Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
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
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(duration: 1000.ms)
                        .then()
                        .fadeOut(duration: 1000.ms),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        'garbageTipsTitle6'.tr,
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
              .slideY(begin: 0.2),
        ],
      ),
    );
  }

  Widget _buildTipCard({
    required IconData icon,
    required MaterialColor color,
    required String title,
    required String description,
    required int delay,
    required bool isDarkMode,
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
                color: color.withValues(alpha: 0.6),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.shade600.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color.shade600, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 15, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
        .fadeIn(delay: delay.ms);
  }
}
