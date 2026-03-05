import 'dart:ui'; // For ImageFilter.blur
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/modules/auth/logic_view/controller/logic_auth_controller.getx.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/cleaning_schedule/view/cleaning_schedule_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/cleaning_tips/view/cleaning_tips_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/view/garbage_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/important_number/view/important_number_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/laundry/view/laundry_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/view/reminders_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/stop_and_think/view/stop_and_think_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/wifi/view/wifi_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/working_hours/view/working_hours_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/map/view/map_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // For animations
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart'; // For staggered grid animations
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chimay_house/core/constant/app_colors.dart'; // Assuming this exists
import 'package:chimay_house/core/functions/helper_functions.dart'; // Assuming this exists

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 28),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(begin: -0.2, duration: 600.ms, curve: Curves.easeOut)
        .fadeIn(duration: 700.ms);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    // final logicController = Get.find<LogicAuthControllerImp>();
    // final logicController=  Get.put(LogicAuthControllerImp());
    final List<_Category> _categories = [
      _Category(
        icon: Icons.alarm_rounded,
        title: 'workingHoursTitle'.tr,
        description: 'workingHoursContent'.tr,
        color: Colors.blue.shade400,
        onTap: () => Get.to(() => WorkingHoursView()),
      ),
      _Category(
        icon: Iconsax.wifi,
        title: 'internetTitle'.tr,
        description: 'internetContent'.tr,
        color: Colors.orange.shade400,
        onTap: () => Get.to(() => WifiView()),
      ),
      _Category(
        icon: Iconsax.call,
        title: 'importantNumbersTitle'.tr,
        description: 'importantNumbersContent'.tr,
        color: Colors.green.shade400,
        onTap: () => Get.to(() => ImportantNumberView()),
      ),
      _Category(
        icon: Icons.gavel,
        title: 'stopAndThinkTitle'.tr,
        description: 'stopAndThinkContent'.tr,
        color: Colors.deepPurple.shade400,
        onTap: () => Get.to(() => StopAndThinkView()),
      ),
      _Category(
        icon: Icons.cleaning_services,
        title: 'cleaningTipsTitle'.tr,
        description: 'cleaningTipsContent'.tr,
        color: Colors.limeAccent.shade400,
        onTap: () => Get.to(() => CleaningTipsView()),
      ),
      _Category(
        icon: Icons.delete_outline,
        title: 'garbageTitle'.tr,
        description: 'garbageContent'.tr,
        color: Colors.indigo.shade400,
        onTap: () => Get.to(() => GarbageView()),
      ),
      _Category(
        icon: Icons.local_laundry_service,
        title: 'laundryTitle'.tr,
        description: 'laundryContent'.tr,
        color: Colors.teal.shade400,
        onTap: () => Get.to(() => LaundryView()),
      ),
      _Category(
        icon: Iconsax.notification,
        title: 'RemaindersTitle'.tr,
        description: 'RemaindersContent'.tr,
        color: Colors.green.shade400,
        onTap: () => Get.to(() => RemindersView()),
      ),
      // _Category(
      //   icon: Icons.account_balance_wallet_outlined,
      //   title: 'weeklyAllowanceTitle'.tr,
      //   description: 'weeklyAllowanceContent'.tr,
      //   color: Colors.green.shade400,
      // ),
      _Category(
        icon: Icons.event_note_outlined,
        title: 'cleaningScheduleTitle'.tr,
        description: 'cleaningScheduleContent'.tr,
        color: Colors.red.shade400,
        onTap: () => Get.to(() => CleaningScheduleView()),
      ),

      _Category(
        icon: Iconsax.location,
        title: 'googleMapTitle'.tr,
        description: 'googleMapContent'.tr,
        color: Colors.amber.shade400,
        onTap: () => Get.to(() => ImportantPlacesView()),
      ),
    ];

    return Scaffold(
      // backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      appBar: CustomAppBar(title: 'servicesAppBarTitle'.tr, showBack: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Explore Section Header
            _buildSectionHeader(
              title: 'servicesExploreCategories'.tr,
              icon: Iconsax.category,
              isDarkMode: isDarkMode,
            ),
            SizedBox(height: 20),

            // Explore Categories Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 203,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(
                        milliseconds: 500,
                      ), // Staggered animation duration
                      columnCount: 2,
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: CategoryCard(
                            icon: category.icon,
                            title: category.title,
                            description: category.description,
                            color: category.color,
                            onTapCategory: category.onTap,
                            isDarkMode: isDarkMode,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Data model for categories
class _Category {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback? onTap;

  _Category({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.onTap,
  });
}

// List of categories

// Redesigned CategoryCard widget
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final void Function()? onTapCategory;
  final bool isDarkMode;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.onTapCategory,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTapCategory,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [const Color(0xFF2C2C2C), const Color(0xFF1E1E1E)]
                  : [const Color(0xFFF9FAFB), const Color(0xFFFFFFFF)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: isDarkMode ? 0.15 : 0.08),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 30), // Larger icon
              ).animate().scale(
                begin: Offset(0.8, 0.8),
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
              SizedBox(height: 16), // Increased spacing
              Text(
                    title,
                    style: TextStyle(
                      fontSize: 20, // Larger title
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                  .animate()
                  .slideY(begin: 0.2, duration: 500.ms)
                  .fadeIn(duration: 600.ms),
              SizedBox(height: 8), // Increased spacing
              Expanded(
                child:
                    Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                        .animate()
                        .slideY(begin: 0.2, duration: 500.ms, delay: 100.ms)
                        .fadeIn(duration: 600.ms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
