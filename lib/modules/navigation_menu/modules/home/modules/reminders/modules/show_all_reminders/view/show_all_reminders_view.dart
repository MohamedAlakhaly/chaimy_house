import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/reminder_model.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/modules/add_reminder/view/add_reminder_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/modules/show_all_reminders/controller/show_all_reminders_controller.getx.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/view/reminders_view.dart';

class ShowAllRemindersView extends StatelessWidget {
  const ShowAllRemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    ShowAllRemindersControllerImp controller = Get.put(
      ShowAllRemindersControllerImp(),
    );
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'showAllRemindersTitle'.tr),
      floatingActionButton:
          GestureDetector(
                onTap: () => Get.to(() => const AddReminderView()),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(Iconsax.add, color: Colors.white, size: 28),
                ),
              )
              .animate()
              .scale(
                // begin: 0.7,
                duration: 600.ms,
                curve: Curves.easeOutBack,
              )
              .fadeIn(duration: 700.ms),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10), // Consistent padding
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                ValueListenableBuilder(
                  valueListenable: controller.remindersBox.listenable(),
                  builder: (context, Box<RemindersModel> box, _) {
                    
                    final reminders = box.values.toList()
                      ..sort((a, b) => a.dateAndTime.compareTo(b.dateAndTime));

                    if (reminders.isEmpty) {
                      return _buildMessageState(
                        isDarkMode: isDarkMode,
                        imagePath: AppImages.noNotificationsAnimation,
                        message: 'warningEmptyReminderTitle'.tr,
                        subMessage: 'warningEmptyReminderContent'.tr,
                      ).animate().fadeIn(duration: 600.ms);
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(), // لأننا داخل SingleChildScrollView
                      itemCount: reminders.length,
                      itemBuilder: (context, index) {
                        final reminder = reminders[index];

                        return ReminderCard(
                              remindersModel: reminder,
                              showDayAndTime: true,

                              onDelete: () =>
                                  controller.deleteReminder(reminder),
                            )
                            .animate()
                            .fadeIn(delay: (index * 100).ms, duration: 600.ms)
                            .slideY(begin: 0.1);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageState({
    required bool isDarkMode,
    required String imagePath,
    required String message,
    required String subMessage,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: double.infinity,
        ), // Add some top spacing
        Lottie.asset(
          imagePath,
          height: 250, // Adjusted height
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 24),
        Text(
          message,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subMessage,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
