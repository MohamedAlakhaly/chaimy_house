import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:chimay_house/models/data/features_app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:iconsax/iconsax.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: "aboutAppAppbar".tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= ABOUT =================
            _sectionCard(
              title: "aboutAppSectionTitle".tr,
              icon: Iconsax.info_circle,
              content: "aboutAppContent".tr,
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 25),

            /// ================= GOALS =================
            BuildModernCard(
              iconColor: Colors.red,
              footerText: 'appGoalsFooter'.tr,
              borderColor: Colors.red,
              title: "appGoalsTitle".tr,
              icon: Iconsax.flag,
              items: [
                "goal1".tr,
                "goal2".tr,
                "goal3".tr,
                "goal4".tr,
                "goal5".tr,
                "goal6".tr,
              ],
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 25),

            /// ================= TARGET =================
            _sectionCard(
              title: "targetGroupTitle".tr,
              icon: Iconsax.people,
              content: "targetGroupContent".tr,
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 35),

            /// ================= FEATURES GRID =================
            Text(
              "mainFeaturesTitle".tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: featuresAppList.length,
              itemBuilder: (context, index) {
                return _aboutItem(
                  icon: featuresAppList[index].icon,
                  title: featuresAppList[index].title.tr,
                  description: featuresAppList[index].description.tr,
                  color: featuresAppList[index].color,
                  isDarkMode: isDarkMode,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),

            const SizedBox(height: 5),

            /// ================= VISION =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF6C5CE7)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const Icon(Iconsax.eye, color: Colors.white, size: 30),
                  const SizedBox(height: 15),
                  Text(
                    "appVisionTitle".tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "appVisionDescription".tr,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms),

            const SizedBox(height: 20),

            /// ================= INITIATIVE =================
            BuildModernCard(
              icon: Icons.code_rounded,
              iconColor: Colors.indigo,
              borderColor: Colors.indigo,
              title: "appInitiativeTitle".tr,
              items: ["appInitiativeContent1".tr, "appInitiativeContent2".tr],
              footerText: "developerCredit".tr,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _sectionCard({
  required String title,
  required IconData icon,
  required String content,
  required bool isDarkMode,
  Color iconColor = const Color(0xFF4A90E2),
  String footerText = '',
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: iconColor.withValues(alpha: 0.25), width: 2),
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
        /// ===== Header =====
        Row(
          children: [
            Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 26),
                )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 300))
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: const Duration(milliseconds: 300),
                ),

            const SizedBox(width: 12),

            Expanded(
              child:
                  Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      )
                      .animate()
                      .fadeIn(
                        duration: const Duration(milliseconds: 300),
                        delay: const Duration(milliseconds: 100),
                      )
                      .slideX(
                        begin: -0.2,
                        end: 0,
                        duration: const Duration(milliseconds: 300),
                        delay: const Duration(milliseconds: 100),
                      ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// ===== Content =====
        Text(
              content,
              style: TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.grey[isDarkMode ? 300 : 700],
              ),
            )
            .animate()
            .fadeIn(
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 200),
            )
            .slideY(
              begin: 0.2,
              end: 0,
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 200),
            ),

        /// ===== Footer (اختياري) =====
        if (footerText.isNotEmpty) ...[
          const SizedBox(height: 16),
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
              )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 300),
              )
              .slideY(
                begin: 0.2,
                end: 0,
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 300),
              ),
        ],
      ],
    ),
  );
}

Widget _aboutItem({
  required IconData icon,
  required String title,
  required String description,
  required Color color,
  required bool isDarkMode,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      gradient: LinearGradient(
        colors: isDarkMode
            ? [const Color(0xFF2C2C2C), const Color(0xFF1E1E1E)]
            : [const Color(0xFFF9FAFB), const Color(0xFFFFFFFF)],
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 30),
        ).animate().scale(
          begin: Offset(0.8, 0.8),
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 15, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    ),
  ).animate().scale();
}
