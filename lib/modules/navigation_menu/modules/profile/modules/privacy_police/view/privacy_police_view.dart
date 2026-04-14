import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: "privacy_policy_title".tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= INTRO =================
            _sectionCard(
              title: "privacy_matters_title".tr,
              icon: Iconsax.shield_tick,
              content: "privacy_matters_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.blue,
            ),

            const SizedBox(height: 25),

            /// ================= DATA =================
            BuildModernCard(
              footerText: 'data_collection_footer'.tr,
              iconColor: Colors.deepPurple,
              borderColor: Colors.deepPurple,
              title: "data_collection_title".tr,
              icon: Iconsax.user,
              items: [
                "name".tr,
                "email".tr,
                "room_number".tr,
                "user_image".tr,
                "location".tr,
              ],
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 25),

            /// ================= USAGE =================
            _sectionCard(
              title: "usage_title".tr,
              icon: Iconsax.activity,
              content: "usage_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.orange,
            ),

            const SizedBox(height: 25),

            /// ================= NOTIFICATIONS =================
            _sectionCard(
              title: "notifications_title".tr,
              icon: Iconsax.notification,
              content: "notifications_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.red,
            ),

            const SizedBox(height: 25),

            /// ================= STORAGE =================
            _sectionCard(
              title: "storage_title".tr,
              icon: Iconsax.cloud,
              content: "storage_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.indigo,
            ),

            const SizedBox(height: 25),

            /// ================= SECURITY =================
            _sectionCard(
              title: "security_title".tr,
              icon: Iconsax.security,
              content: "security_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.green,
            ),

            const SizedBox(height: 25),

            /// ================= LOCATION =================
            _sectionCard(
              title: "location_usage_title".tr,
              icon: Iconsax.location,
              content: "location_usage_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.teal,
            ),

            const SizedBox(height: 25),

            /// ================= SHARING =================
            _sectionCard(
              title: "sharing_title".tr,
              icon: Iconsax.people,
              content: "sharing_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.pink,
            ),

            const SizedBox(height: 25),

            /// ================= APP TYPE =================
            _sectionCard(
              title: "app_nature_title".tr,
              icon: Iconsax.home,
              content: "app_nature_desc".tr,
              isDarkMode: isDarkMode,
              iconColor: Colors.cyan,
            ),

            const SizedBox(height: 25),

            /// ================= CONTACT =================
            _sectionCard(
              title: "contact_us_title".tr,
              icon: Iconsax.message,
              content: "${"contact_us_desc".tr}\nalakhail755@email.com",
              isDarkMode: isDarkMode,
              iconColor: Colors.amber,
            ),

            const SizedBox(height: 30),

            /// ================= FOOTER =================
            Center(
              child: Text(
                "last_update".tr,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
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
}