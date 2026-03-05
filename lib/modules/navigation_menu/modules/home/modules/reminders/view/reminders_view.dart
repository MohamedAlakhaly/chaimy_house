import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart'; // Assuming this exists
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/reminder_model.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/controller/reminders_controller.getx.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/modules/add_reminder/view/add_reminder_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/modules/show_all_reminders/view/show_all_reminders_view.dart';
import 'package:table_calendar/table_calendar.dart';

class RemindersView extends StatelessWidget {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    final RemindersControllerImp controller = Get.put(RemindersControllerImp());
    final bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'reminderTitle'.tr,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => ShowAllRemindersView()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.primary.withValues(alpha: 0.8),
              ),
              child: Text(
                'showAllReminders'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      floatingActionButton: GestureDetector(
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
          child: const Icon(Iconsax.add, color: Colors.white, size: 28),
        ),
      ).animate().scale(duration: 600.ms).fadeIn(duration: 700.ms),

      // داخل كلاس RemindersView وفي دالة build:

      // ... الكود العلوي (Scaffold, AppBar) يبقى كما هو ...
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            // استبدال StreamBuilder بـ ValueListenableBuilder
            child: ValueListenableBuilder(
              valueListenable: controller.remindersBox.listenable(),
              builder: (context, Box<RemindersModel> box, _) {
                // 1. جلب كل التذكيرات من Hive
                final allReminders = box.values.toList();

                return Column(
                  children: [
                    // التقويم (Calendar)
                    Obx(
                      () => TableCalendar(
                        locale: controller.langCode,
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: controller.focusedDay.value,
                        selectedDayPredicate: (day) =>
                            isSameDay(controller.selectedDay.value, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          controller.selectedDay.value = selectedDay;
                          controller.focusedDay.value = focusedDay;
                        },
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: const BoxDecoration(
                            color: Colors.orangeAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
                    ),

                    const SizedBox(height: 20),

                    // عرض التذكيرات المفلترة حسب اليوم المختار
                    Obx(() {
                      final selected = controller.selectedDay.value;

                      // 2. تصفية التذكيرات لليوم المحدد فقط
                      final filteredReminders = allReminders.where((reminder) {
                        return isSameDay(reminder.dateAndTime, selected);
                      }).toList();

                      if (filteredReminders.isEmpty) {
                        return Column(
                          children: [
                            _buildMessageState(
                              isDarkMode: isDarkMode,
                              imagePath: AppImages.noNotificationsAnimation,
                              message: 'warningEmptyReminderFilterTitle'.tr,
                              subMessage:
                                  'warningEmptyReminderFilterContent'.tr,
                            ).animate().fadeIn(duration: 600.ms),
                            const SizedBox(height: 100),
                          ],
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredReminders.length,
                        itemBuilder: (context, index) {
                          final reminder = filteredReminders[index];
                          return ReminderCard(
                                remindersModel: reminder,
                                showDayAndTime: false,
                              )
                              .animate()
                              .fadeIn(delay: (index * 100).ms)
                              .slideY(begin: 0.1);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                      );
                    }),

                    SizedBox(height: 60),
                  ],
                );
              },
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
        const SizedBox(width: double.infinity),
        Lottie.asset(imagePath, height: 250, fit: BoxFit.contain),
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

class ReminderCard extends StatelessWidget {
  final RemindersModel remindersModel;
  final bool showDayAndTime;
  final VoidCallback? onDelete;
  const ReminderCard({
    super.key,
    required this.remindersModel,
    required this.showDayAndTime,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String getTimeRemaining(DateTime scheduledDate) {
      final now = DateTime.now();
      final difference = scheduledDate.difference(now);

      if (difference.isNegative) return 'passed'.tr;

      if (difference.inDays >= 30) {
        int months = (difference.inDays / 30).floor();
        return "${'after'.tr} $months ${months > 1 ? 'months'.tr : 'month'.tr}";
      } else if (difference.inDays > 0) {
        return "${'after'.tr} ${difference.inDays} ${difference.inDays > 1 ? 'days'.tr : 'day'.tr}";
      } else if (difference.inHours > 0) {
        return "${'after'.tr} ${difference.inHours} ${difference.inHours > 1 ? 'hours'.tr : 'hour'.tr}";
      } else {
        return "${'after'.tr} ${difference.inMinutes} ${'minutes'.tr}";
      }
    }

    final controller = Get.find<RemindersControllerImp>();
    final DateTime dateTime = remindersModel.dateAndTime;
    AppServices services = Get.find();
    String? langCode =
        services.sharedPreferences.getString('langCode') ??
        Get.deviceLocale?.languageCode ??
        'EN';
    final formattedDate = DateFormat(
      'EEEE, dd MMM yyyy',
      langCode,
    ).format(dateTime);
    final formattedTime = DateFormat('hh:mm a', langCode).format(dateTime);
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    final Color cardBorderColor =
        controller.appointmentTypeColors[remindersModel.type] ??
        AppColors.primary;
    final IconData cardIcon =
        controller.appointmentTypeIcons[remindersModel.type] ?? Iconsax.tag;

    return Dismissible(
      key: Key(remindersModel.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Iconsax.trash, color: Colors.white, size: 32),
      ),
      confirmDismiss: (direction) async {
        // Show confirmation dialog before dismissing
        return await Get.dialog<bool>(
              AlertDialog(
                backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text(
                  'deleteReminderMessageTitle'.tr,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                content: Text(
                  'deleteReminderMessageContent'.tr,
                  style: TextStyle(
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: Text(
                      'cancelButton'.tr,
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'deleteButton'.tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ) ??
            false; // Return false if dialog is dismissed without selection
      },
      onDismissed: (direction) {
        controller.deleteReminder(remindersModel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBorderColor.withValues(alpha: 0.1), // Adaptive background
          borderRadius: BorderRadius.circular(16), // More rounded corners
          // داخل الـ BoxDecoration الخاص بالـ child Container
          border: Border(
            right: langCode == 'ar' || langCode == 'ps'
                ? BorderSide(color: cardBorderColor, width: 5)
                : BorderSide.none,
            left: langCode != 'ar' || langCode == 'ps'
                ? BorderSide(color: cardBorderColor, width: 5)
                : BorderSide.none,
          ), // Subtle border
          boxShadow: [
            BoxShadow(
              color: cardBorderColor.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cardBorderColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Icon(
                  cardIcon,
                  size: 32,
                  color: cardBorderColor, // Icon color matches border
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      remindersModel.type.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 4),
                    showDayAndTime == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white10
                                  : Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Iconsax.calendar_1,
                                  size: 14,
                                  color: cardBorderColor,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    '$formattedDate  |   $formattedTime',
                                    style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.white10
                                  : Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Iconsax.clock,
                                  size: 14,
                                  color: cardBorderColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 8),
                    // Location
                    if (remindersModel.location.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 16,
                            color: isDarkMode
                                ? Colors.grey[500]
                                : Colors.grey[700],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              remindersModel.location,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 4),
                    // Note
                    if (remindersModel.note.isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Iconsax.note_1,
                            size: 16,
                            color: isDarkMode
                                ? Colors.grey[500]
                                : Colors.grey[700],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              remindersModel.note,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          // نجعل اللون أحمر إذا كان الموعد اليوم، وغير ذلك نستخدم لون الكارد
                          color:
                              remindersModel.dateAndTime
                                      .difference(DateTime.now())
                                      .inDays <
                                  1
                              ? Colors.redAccent.withValues(alpha: 0.1)
                              : cardBorderColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                remindersModel.dateAndTime
                                        .difference(DateTime.now())
                                        .inDays <
                                    1
                                ? Colors.redAccent.withValues(alpha: 0.3)
                                : cardBorderColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          getTimeRemaining(remindersModel.dateAndTime),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color:
                                remindersModel.dateAndTime
                                        .difference(DateTime.now())
                                        .inDays <
                                    1
                                ? Colors.redAccent
                                : cardBorderColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
