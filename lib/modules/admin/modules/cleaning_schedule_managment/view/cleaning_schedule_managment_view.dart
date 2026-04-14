import 'dart:developer';

import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/functions/input_validation.dart';
import 'package:chimay_house/core/functions/responsive.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_button_with_blur_background.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/models/static/cleaning_schedule_model.dart';
import 'package:chimay_house/modules/admin/modules/cleaning_schedule_managment/controller/cleaning_schedule_managment_controller.getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

class CleaningScheduleManagementView
    extends GetView<CleaningScheduleManagementControllerImp> {
  const CleaningScheduleManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = Responsive.isDesktop(context);
    Get.lazyPut(() => CleaningScheduleManagementControllerImp(), fenix: true);

    void showInputDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: controller.globalKey,
            child: AlertDialog(
              title: const Text('Ajouter une chambre'), // Add room -> Ajouter une chambre
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 400),
                    CustomTextFormFieldWidget(
                      validator: (val)=>inputValidation(3, 1, val!, 'room'),
                      controller: controller.roomController,
                      keyboardType: TextInputType.number,
                      hintText: 'Numéro de chambre', // Room number -> Numéro de chambre
                      prefixIcon: Iconsax.home,
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormFieldWidget(
                      validator: (val)=>inputValidation(30, 1, val!, 'date'),
                      controller: controller.date1Controller,
                      readOnly: true,
                      hintText: 'Date de début', // Start date -> Date de début
                      prefixIcon: Iconsax.calendar,
                      onTap: () => controller.selectDate(
                        context,
                        controller.date1Controller,
                        true,
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextFormFieldWidget(
                      validator: (val)=>inputValidation(30, 1, val!, 'date'),
                      controller: controller.date2Controller,
                      readOnly: true,
                      hintText: 'Date de fin', // End date -> Date de fin
                      prefixIcon: Iconsax.calendar,
                      onTap: () => controller.selectDate(
                        context,
                        controller.date2Controller,
                        false,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.2),
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.cancel_outlined),
                              SizedBox(width: 5),
                              Text('Annuler'), // Cancle -> Annuler
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() {
                        return GestureDetector(
                          onTap: controller.saveData,
                          child: SizedBox(
                            height: 45,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                border: Border.all(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.primary,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(Iconsax.add),
                                        SizedBox(width: 5),
                                        Text('Enregistrer'), // Save -> Enregistrer
                                      ],
                                    ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cleaningSchedule')
            .orderBy('room', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          int count = snapshot.data?.docs.length ?? 0;

          return ListView(
            children: [
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gérer le planning de nettoyage', // Manage Cleaning Schedule -> Gérer le planning de nettoyage
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Organiser et gérer les horaires des chambres', // Organize and manage room schedules -> Organiser et gérer les horaires des chambres
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.cleaning_services_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha:0.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '$count   Total des chambres', // Total Rooms -> Total des chambres
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),

                          GestureDetector(
                            onTap: showInputDialog,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                border: Border.all(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Iconsax.add),
                                  Text('Ajouter'), // Add room (shortened) -> Ajouter
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Confirmer la suppression', // Confirm deletion -> Confirmer la suppression
                                text:
                                    'Êtes-vous sûr de vouloir supprimer tout le planning de nettoyage ?', // Are you sure... -> Êtes-vous sûr de vouloir supprimer tout le planning de nettoyage ?
                                showConfirmBtn: true,
                                showCancelBtn: true,
                                confirmBtnText: 'Supprimer', // Delete -> Supprimer
                                cancelBtnText: 'Annuler', // Cancle -> Annuler
                                confirmBtnColor: Colors.red,
                                onConfirmBtnTap: () =>
                                    controller.deleteAllOfCleaningSchedule(),
                                onCancelBtnTap: () => Get.back(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.2),
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.delete_outline_outlined),
                                  Text('Tout supprimer'), // Delete all -> Tout supprimer
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 900.ms)
                  .slideY(begin: -0.1, duration: 900.ms, curve: Curves.easeOut),

              const SizedBox(height: 20),

              if (snapshot.hasError)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.infinity, height: 100),
                    SvgPicture.asset(AppImages.errorGetData, height: 250),
                    const SizedBox(height: 20),
                    Text(
                      'cleaningScheduleErrorGetDataTitle'.tr, // تبقى كما هي لأنها مفتاح ترجمة
                      style: AppTextStyle.titleStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'cleaningScheduleErrorGetDataContent'.tr, // تبقى كما هي
                      textAlign: TextAlign.center,
                      style: AppTextStyle.contentStyle,
                    ),
                  ],
                )
              else if (snapshot.connectionState == ConnectionState.waiting)
                CustomLoadingCircular()
              else if (snapshot.data!.docs.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.infinity, height: 100),
                    Lottie.asset(
                      AppImages.noNotificationsAnimation,
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Text('Vide', style: AppTextStyle.titleStyle), // Empty -> Vide
                    const SizedBox(height: 8),
                    Text(
                      "Il n'y a pas de nouveaux utilisateurs", // There is no new users -> Il n'y a pas de nouveaux utilisateurs
                      textAlign: TextAlign.center,
                      style: AppTextStyle.contentStyle,
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms)
              else
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:isDesktop? 2:1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 230,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final cleaningScheduleData = CleaningScheduleModel.fromMap(
                      doc.data(),
                      doc.id,
                    );

                    return CustomCleaningScheduleCard(
                          cleaningScheduleData: cleaningScheduleData,
                          controller: controller,
                        )
                        .animate()
                        .fadeIn(delay: (200 + index * 100).ms, duration: 600.ms)
                        .slideY(
                          begin: 0.2,
                          delay: (200 + index * 100).ms,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        )
                        .then(delay: 500.ms);
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
class CustomCleaningScheduleCard extends StatelessWidget {
  const CustomCleaningScheduleCard({
    super.key,
    required this.cleaningScheduleData,
    required this.controller,
  });

  final CleaningScheduleModel cleaningScheduleData;
  final CleaningScheduleManagementControllerImp controller;

  @override
  Widget build(BuildContext context) {
    AppServices services = Get.find();

    DateTime now = DateTime.now();
    DateTime endDateTime = cleaningScheduleData.endDate.toDate();
    bool isExpired = now.isAfter(endDateTime); 
    // --------------------------------------------------

    Color activeColor = isExpired ? Colors.grey.shade800 : AppColors.primary;

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
        gradient: LinearGradient(
          colors: [
            activeColor.withValues(alpha: 0.1),
            activeColor.withValues(alpha: 0.05),
          ],
        ),
        color: (isDarkMode ? Colors.grey.shade900 : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: activeColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: activeColor.withValues(alpha: 0.2),
            blurRadius: 15,
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
                      color: activeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  Icon(
                      Icons.cleaning_services_rounded,
                      color: activeColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'cleaningScheduleRoomTitle'.tr, // مفتاح ترجمة
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

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          activeColor,
                          activeColor.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: activeColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.calendar_1, color: Colors.white, size: 18),
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
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Confirmer la suppression', // Confirm deletion -> Confirmer la suppression
                        text:
                            'Êtes-vous sûr de vouloir supprimer ce planning ?', // Are you sure... -> Êtes-vous sûr de vouloir supprimer ce planning ?
                        showConfirmBtn: true,
                        showCancelBtn: true,
                        confirmBtnText: 'Supprimer', // Delete -> Supprimer
                        cancelBtnText: 'Annuler', // Cancle -> Annuler
                        confirmBtnColor: Colors.red,
                        onConfirmBtnTap: () {
                          controller.deleteOneOfCleaningSchedule(
                            cleaningScheduleData.id,
                          );
                        },
                        onCancelBtnTap: () => Get.back(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.red.withValues(alpha: 0.8),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.delete_outline_outlined, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Supprimer', // Delete -> Supprimer
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                            'cleaningScheduleFromDate'.tr, // مفتاح ترجمة
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
                            'cleaningScheduleToDate'.tr, // مفتاح ترجمة
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

          if (isExpired)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.2),
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Expiré',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )

            
        ],
      ),
    );
  }
}