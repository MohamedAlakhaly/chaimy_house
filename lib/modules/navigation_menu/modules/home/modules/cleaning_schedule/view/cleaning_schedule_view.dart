import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/cleaning_schedule_model.dart';
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
              
            
              FutureBuilder(
                future: controller.cleaningSchedule,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _buildMessageState(
                      isDarkMode: isDarkMode,
                      imagePath: AppImages.errorGetData,
                      message: 'cleaningScheduleErrorGetDataTitle'.tr,
                      subMessage: 'cleaningScheduleErrorGetDataContent'.tr,
                    ).animate().fadeIn(duration: 600.ms);
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomLoadingCircular();
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return _buildMessageState(
                      isDarkMode: isDarkMode,
                      imagePath: AppImages.cleaningScheduleEmpty,
                      message: 'cleaningScheduleEmptyTitle'.tr,
                      subMessage: 'cleaningScheduleEmptyContent'.tr,
                    ).animate().fadeIn(duration: 600.ms);
                  }

                  return Column(
                    children: [
                        Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'cleaningScheduleViewContent'.tr,
                            style: TextStyle(
                              fontSize: AppFontsSize.smallFontSize,
                              color: isDarkMode
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, duration: 600.ms, curve: Curves.easeOut),
                  const SizedBox(height: 20),


                      ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final cleaningScheduleSnaphote =
                              snapshot.data!.docs[index];
                          final cleaningScheduleData =
                              CleaningScheduleModel.fromMap(
                                cleaningScheduleSnaphote.data()
                                    as Map<String, dynamic>,
                                cleaningScheduleSnaphote.id,
                              );
                      
                          return Obx(() {
                            final isUserRoom =
                                controller.userDate['roomNumber'] ==
                                cleaningScheduleData.roomNumber;
                            return CustomCleaningScheduleCard(
                                  isUserRoom: isUserRoom,
                                  cleaningScheduleData: cleaningScheduleData,
                                )
                                .animate()
                                .fadeIn(
                                  delay: (200 + index * 100).ms,
                                  duration: 600.ms,
                                )
                                .slideX(
                                  begin: 0.2,
                                  delay: (200 + index * 100).ms,
                                  duration: 600.ms,
                                  curve: Curves.easeOut,
                                )
                                .then(delay: isUserRoom ? 500.ms : 0.ms)
                                .shimmer(
                                  duration: isUserRoom ? 2000.ms : 0.ms,
                                  color: isUserRoom
                                      ? AppColors.primary.withValues(alpha: 0.3)
                                      : Colors.transparent,
                                );
                          });
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                      ),
                    ],
                  );
                },
              ),
            ],
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
        ),
        SvgPicture.asset(
          imagePath,
          height: 250,
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

    String formatFirestoreTimestampOnlyMonth(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate().add(const Duration(hours: 3));
      return DateFormat("MMMM", services.getUserLanguage()).format(dateTime);
    }

    String formatFirestoreTimestamp(Timestamp timestamp) {
      DateTime dateTime = timestamp.toDate().add(const Duration(hours: 3));
      return DateFormat("dd / MM / y").format(dateTime);
    }

    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: isUserRoom
            ? LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.1),
                  AppColors.primary.withValues(alpha: 0.05),
                ],
              )
            : null,
        color: isUserRoom
            ? null
            : (isDarkMode ? Colors.grey.shade900 : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUserRoom
              ? AppColors.primary
              : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200),
          width: isUserRoom ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isUserRoom
                ? AppColors.primary.withValues(alpha: 0.2)
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: isUserRoom ? 15 : 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.cleaning_services_rounded,
                      color: AppColors.primary,
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
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
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
                        color: Colors.green.shade600,
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
                              color: isDarkMode ? Colors.white : Colors.black87,
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
                      Icon(Icons.stop, color: Colors.red.shade600, size: 20),
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
                              color: isDarkMode ? Colors.white : Colors.black87,
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

          if (isUserRoom) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
