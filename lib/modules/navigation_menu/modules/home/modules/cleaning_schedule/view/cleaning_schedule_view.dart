import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/cleaning_schedule_model.dart';
import 'package:chimay_house/modules/navigation_menu/modules/events/view/events_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/cleaning_schedule/controller/cleaning_schedule_controller.getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class CleaningScheduleView extends StatelessWidget {
  const CleaningScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    CleaningScheduleControllerImp controller = Get.put(
      CleaningScheduleControllerImp(),
    );

    return Scaffold(
      appBar: CustomAppBar(title: 'cleaningScheduleViewTitle'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // نستخدم Obx لمراقبة حالة التحميل والقائمة
              Obx(() {
                if (controller.isLoading.value) {
                  return const CustomLoadingCircular();
                }

                if (controller.schedules.isEmpty) {
                  return CustomStreamState(
                    image: AppImages.cleaningScheduleEmpty,
                    title: 'cleaningScheduleEmptyTitle'.tr,
                    content: 'cleaningScheduleEmptyContent'.tr,
                  ).animate().fadeIn(duration: 600.ms);
                }

                return Column(
                  children: [
                    _buildInfoCard(
                      isDarkMode,
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),

                    const SizedBox(height: 20),

                    ListView.separated(
                      itemCount: controller.schedules.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final doc = controller.schedules[index];
                        final cleaningScheduleData =
                            CleaningScheduleModel.fromMap(
                              doc.data() as Map<String, dynamic>,
                              doc.id,
                            );

                        final isUserRoom =
                            controller.userDate['roomNumber'] ==
                            cleaningScheduleData.roomNumber;

                        return CustomCleaningScheduleCard(
                              isUserRoom: isUserRoom,
                              cleaningScheduleData: cleaningScheduleData,
                            )
                            .animate()
                            .fadeIn(delay: (index * 100).ms)
                            .slideX(begin: 0.2);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : Colors.white,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'cleaningScheduleViewContent'.tr,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCleaningScheduleCard extends StatelessWidget {
  const CustomCleaningScheduleCard({
    super.key,
    required this.isUserRoom,
    required this.cleaningScheduleData,
  });

  final bool isUserRoom;
  final CleaningScheduleModel cleaningScheduleData;

  @override
  Widget build(BuildContext context) {
    AppServices services = Get.find();

    final bool isExpired = cleaningScheduleData.endDate.toDate().isBefore(
      DateTime.now(),
    );
    String rawLang =
        services.sharedPreferences.getString('langCode') ??
        Get.deviceLocale?.languageCode ??
        'en';

    List<String> dateSafeLocales = ['en', 'ar', 'fr', 'es', 'tr', 'nl', 'uk'];
    String safeLocale = dateSafeLocales.contains(rawLang) ? rawLang : 'en';

    String formatFirestoreTimestampOnlyMonth(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate().add(const Duration(hours: 3));
      return DateFormat("MMMM", safeLocale).format(dateTime);
    }

    String formatFirestoreTimestamp(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate().add(const Duration(hours: 3));
      return DateFormat("dd / MM / y", safeLocale).format(dateTime);
    }

    bool isDarkMode = HelperFunctions.isDarkMode(context);

    Color dynamicPrimaryColor = isExpired ? Colors.grey : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: isUserRoom
            ? LinearGradient(
                colors: [
                  dynamicPrimaryColor.withValues(alpha: 0.1),
                  dynamicPrimaryColor.withValues(alpha: 0.05),
                ],
              )
            : null,
        color: isUserRoom
            ? null
            : (isDarkMode ? Colors.grey.shade900 : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUserRoom
              ? dynamicPrimaryColor
              : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200),
          width: isUserRoom ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isUserRoom
                ? dynamicPrimaryColor.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: isUserRoom ? 15 : 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Opacity(
        opacity: isExpired ? 0.7 : 1.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: dynamicPrimaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.cleaning_services_rounded,
                        color: dynamicPrimaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'cleaningScheduleRoomTitle'.tr,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          cleaningScheduleData.roomNumber.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        dynamicPrimaryColor,
                        dynamicPrimaryColor.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: dynamicPrimaryColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.calendar_1,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatFirestoreTimestampOnlyMonth(
                          cleaningScheduleData.startDate,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey.shade800.withValues(alpha: 0.5)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: isExpired
                              ? Colors.grey
                              : Colors.green.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'cleaningScheduleFromDate'.tr,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatFirestoreTimestamp(
                                cleaningScheduleData.startDate,
                              ),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Icon(
                          Icons.stop,
                          color: isExpired ? Colors.grey : Colors.red.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'cleaningScheduleToDate'.tr,
                              style: TextStyle(
                                fontSize: 11,
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatFirestoreTimestamp(
                                cleaningScheduleData.endDate,
                              ),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isUserRoom && !isExpired) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .fadeIn(duration: 1000.ms)
                        .then()
                        .fadeOut(duration: 1000.ms),
                    const SizedBox(width: 8),
                    Text(
                      'cleaningScheduleToDateYourRoomLable'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (isExpired) ...[
              const SizedBox(height: 12),
              Text(
                'cleaningScheduleFinishedLable'.tr,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
