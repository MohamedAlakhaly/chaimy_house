import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndividualSupportView extends StatelessWidget {
  const IndividualSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    const Color mainColor = Colors.indigo;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'individual_support_page_title'.tr,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BuildModernCard(
              icon: Icons.verified_user_rounded,
              iconColor: mainColor,
              title: 'ethics_title'.tr,
              items: [
                'ethics_item_1'.tr,
              ],
              footerText: 'ethics_footer'.tr,
              borderColor: mainColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.person_rounded,
              iconColor: Colors.teal,
              title: 'social_worker_title'.tr,
              items: [
                'social_worker_item_1'.tr,
                'social_worker_item_2'.tr,
                'social_worker_item_3'.tr,
                'social_worker_item_4'.tr,
              ],
              footerText: 'social_worker_footer'.tr,
              borderColor: Colors.teal,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.folder_shared_rounded,
              iconColor: Colors.purple,
              title: 'social_file_title'.tr,
              items: [
                'social_file_item_1'.tr,
                'social_file_item_2'.tr,
                'social_file_item_3'.tr,
                'social_file_item_4'.tr,
                'social_file_item_5'.tr,
              ],
              footerText: 'social_file_footer'.tr,
              borderColor: Colors.purple,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.home_rounded,
              iconColor: Colors.green,
              title: 'support_inside_title'.tr,
              items: [
                'support_inside_item_1'.tr,
              ],
              footerText: 'support_inside_footer'.tr,
              borderColor: Colors.green,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.location_city_rounded,
              iconColor: Colors.orange,
              title: 'support_outside_title'.tr,
              items: [
                'support_outside_item_1'.tr,
                'support_outside_item_2'.tr,
              ],
              footerText: 'support_outside_footer'.tr,
              borderColor: Colors.orange,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.gavel_rounded,
              iconColor: Colors.deepPurple,
              title: 'asylum_support_title'.tr,
              items: [
                'asylum_support_item_1'.tr,
                'asylum_support_item_2'.tr,
                'asylum_support_item_3'.tr,
                'asylum_support_item_4'.tr,
                'asylum_support_item_5'.tr,
                'asylum_support_item_6'.tr,
              ],
              footerText: 'asylum_support_footer'.tr,
              borderColor: Colors.deepPurple,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            BuildModernCard(
              icon: Icons.school_rounded,
              iconColor: Colors.cyan,
              title: 'education_title'.tr,
              items: [
                'education_item_1'.tr,
                'education_item_2'.tr,
                'education_item_3'.tr,
                'education_item_4'.tr,
              ],
              footerText: 'education_footer'.tr,
              borderColor: Colors.cyan,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}
