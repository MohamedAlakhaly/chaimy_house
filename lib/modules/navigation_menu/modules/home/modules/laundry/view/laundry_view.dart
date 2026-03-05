import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/models/data/laundry_data.dart';
import 'package:chimay_house/models/static/laundry_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class CustomLaundryCard extends StatelessWidget {
  final LaundryModel laundryModel;
  final bool isDarkMode;
  final int index;

  const CustomLaundryCard({
    super.key,
    required this.laundryModel,
    required this.isDarkMode,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  laundryModel.icons,
                  color: AppColors.primary,
                  size: 20,
                ),
              ).animate().scale(
                begin: Offset(0.8, 0.8),
                duration: 300.ms,
                curve: Curves.easeOut,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  laundryModel.title.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ).animate().slideX(begin: -0.3, duration: 400.ms),
              ),
            ],
          ),
          SizedBox(height: 12),
          ExpandableText(
            laundryModel.description.tr,
            expandText: 'show more button'.tr,
            collapseText: 'show less button'.tr,
            maxLines: 4,
            linkColor: AppColors.primary,
            animation: true,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
            ),
          ).animate(delay: 100.ms).slideY(begin: 0.3, duration: 400.ms),
        ],
      ),
    );
  }
}

// 3. Main Asylum Procedures View
class LaundryView extends StatelessWidget {
  const LaundryView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'laundryAppBarTitle'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'asylum procedures tab'.tr,
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: AppFontsSize.mediumFontSize,
            //   ),
            // ).animate().slideY(
            //   begin: -0.3,
            //   duration: 500.ms,
            //   curve: Curves.easeOut,
            // ),
            SizedBox(height: 20),
            // Introduction Section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDarkMode ? 0.3 : 0.08,
                    ),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        'laundryCategoryTitle'.tr,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      )
                      .animate()
                      .slideY(
                        begin: -0.3,
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(duration: 700.ms),
                  SizedBox(height: 12),
                  Text(
                        'laundryCategoryDescription'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: isDarkMode
                              ? Colors.grey[300]
                              : Colors.grey[700],
                        ),
                      )
                      .animate(delay: 200.ms)
                      .slideY(begin: 0.3, duration: 600.ms)
                      .fadeIn(duration: 700.ms),
                ],
              ),
            ).animate().slideY(
              begin: -0.5,
              duration: 800.ms,
              curve: Curves.easeOutBack,
            ),

            SizedBox(height: 30),

            // Timeline Section Header
            _buildSectionHeader(
                  title: 'laundryStepsTitle'.tr,
                  icon: Icons.timeline,
                  isDarkMode: isDarkMode,
                )
                .animate()
                .slideY(begin: -0.3, duration: 600.ms)
                .fadeIn(duration: 700.ms),
            SizedBox(height: 16),

            // Enhanced Timeline of Asylum Procedures
            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: laundryData.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🟢 مؤشر المرحلة
                            Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isDarkMode
                                          ? Colors.white.withValues(alpha: 0.2)
                                          : Colors.white,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.4,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ).animate().scale(
                                  begin: const Offset(0.7, 0.7),
                                  duration: 500.ms,
                                  curve: Curves.elasticOut,
                                ),
                                if (index < laundryData.length - 1)
                                  Container(
                                    width: 4,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.primary.withValues(
                                            alpha: 0.8,
                                          ),
                                          AppColors.primary.withValues(
                                            alpha: 0.2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomLaundryCard(
                                laundryModel: laundryData[index],
                                isDarkMode: isDarkMode,
                                index: index,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
