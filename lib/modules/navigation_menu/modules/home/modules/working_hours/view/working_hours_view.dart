import 'dart:developer';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkingHoursView extends StatelessWidget {
  final now = DateTime.now();

  WorkingHoursView({super.key});

  bool isOfficeOpen(DateTime now) {
    int day = now.weekday;

    bool inRange(int startHour, int startMinute, int endHour, int endMinute) {
      final start = DateTime(
        now.year,
        now.month,
        now.day,
        startHour,
        startMinute,
      );
      final end = DateTime(now.year, now.month, now.day, endHour, endMinute);
      return now.isAfter(start) && now.isBefore(end);
    }

    if (day == 1) {
      return inRange(9, 15, 11, 45) || inRange(14, 00, 15, 45);
    } else if (day >= 2 && day <= 5) {
      return inRange(9, 15, 11, 45);
    }

    return false;
  }

  final String phoneNumber = "32473680154";
  final String message =
      'Bonjour, je souhaiterais prendre rendez-vous avec l\'administration. Pourriez-vous m\'indiquer les créneaux horaires disponibles ? Merci.';

  void openWhatsApp() async {
    var url = "whatsapp://send?phone=$phoneNumber&text=${Uri.parse(message)}";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      var webUrl = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    log(now.weekday.toString());
    final open = isOfficeOpen(now);

    return Scaffold(
      appBar: CustomAppBar(title: 'workingHourseTitle'.tr),
      bottomNavigationBar:
          Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                color: isDarkMode ? AppColors.bgDark : AppColors.bgLight,
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    height: 50,
                    child: CustomButtonWithShadow(
                      buttonText: 'Make appointment',
                      buttonColor: AppColors.primary,
                      onTap: openWhatsApp,
                    ),
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 800.ms, curve: Curves.easeOut)
              .scale(begin: const Offset(0.8, 0.8), duration: 600.ms)
              .then(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),

              Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(AppImages.workingTime, height: 220),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                  .scale(begin: const Offset(0.8, 0.8), duration: 600.ms)
                  .then(),

              // .shimmer(
              //   duration: 2000.ms,
              //   color: AppColors.primary.withValues(alpha: 0.2),
              // ),
              const SizedBox(height: 40),

              Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: open
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.red.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                open ? Icons.check_circle : Icons.cancel,
                                color: open
                                    ? Colors.green.shade500
                                    : Colors.red.shade500,
                                size: 32,
                              ),
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .scale(
                              begin: const Offset(1.0, 1.0),
                              end: const Offset(1.1, 1.1),
                              duration: 2000.ms,
                            )
                            .then()
                            .scale(
                              begin: const Offset(1.1, 1.1),
                              end: const Offset(1.0, 1.0),
                              duration: 2000.ms,
                            ),

                        const SizedBox(height: 16),

                        Text(
                          open
                              ? 'officeIsOpenTitle'.tr
                              : 'officeIsCloseTitle'.tr,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: open
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.3),

                        const SizedBox(height: 8),

                        Text(
                          open
                              ? 'officeIsOpenContent'.tr
                              : 'officeIsCloseContent'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().fadeIn(delay: 500.ms),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 200.ms),

              const SizedBox(height: 30),

              Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'officeWeeklySchedule'.tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildScheduleItem(
                                "officeWorkingMonday".tr,
                                "9:15 - 11:45",
                                "14:00 - 15:45",
                                Icons.calendar_today,
                                0,
                                isDarkMode,
                                now.weekday == 1,
                              ),
                              const SizedBox(height: 16),
                              _buildScheduleItem(
                                "officeWorkingTuesdayToFriday".tr,
                                "9:15 - 11:45",
                                "officeWorkingTuesdayToFridayByAppointment".tr,
                                Icons.event_available,
                                1,
                                isDarkMode,
                                (now.weekday >= 2 && now.weekday <= 5),
                              ),
                              const SizedBox(height: 16),
                              _buildScheduleItem(
                                "officeWorkingWeekend".tr,
                                "officeWorkingWeekendTime".tr,
                                "officeWorkingWeekendTime".tr,
                                Icons.weekend,
                                2,
                                isDarkMode,
                                (now.weekday == 6 || now.weekday == 7),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(
    String day,
    String morning,
    String afternoon,
    IconData icon,
    int index,
    bool isDarkMode,
    bool isActive,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.15)
            : (isDarkMode ? Colors.grey[850] : Colors.grey[200]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? AppColors.primary
              : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: isActive ? Colors.white : AppColors.primary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.primary : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${'officeWorkingMorningTitle'.tr}: $morning",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                  ),
                ),
                Text(
                  "${'officeWorkingAfternoonTitle'.tr}: $afternoon",
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (800 + index * 200).ms);
  }
}
