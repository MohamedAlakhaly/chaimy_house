import 'dart:developer';
import 'dart:io';

import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/functions/input_validation.dart';
import 'package:chimay_house/global/custom_button_with_icon.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:chimay_house/models/static/events_model.dart';
import 'package:chimay_house/modules/admin/modules/events_management/controller/events_management_controller.getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

class EventManagementView extends GetView<EventsManagementControllerImp> {
  const EventManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EventsManagementControllerImp(), fenix: true);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('eventDate')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: double.infinity, height: 100),
                SvgPicture.asset(AppImages.errorGetData, height: 250),
                const SizedBox(height: 20),
                Text(
                  'cleaningScheduleErrorGetDataTitle'
                      .tr, // مترجم عبر ملفات الـ Localization
                  style: AppTextStyle.titleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'cleaningScheduleErrorGetDataContent'
                      .tr, // مترجم عبر ملفات الـ Localization
                  textAlign: TextAlign.center,
                  style: AppTextStyle.contentStyle,
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomLoadingCircular();
          }

          final events = snapshot.data!.docs;
          final count = events.length;

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
                                  'Gérer les événements',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Organisez et gérez tous les événements.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withValues(alpha:0.7),
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
                              Icons.event_available_rounded,
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
                              color: AppColors.primary.withValues(alpha: 0.15),
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
                                  '$count   Total des événements',
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
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Créer un événement',
                                content: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Form(
                                    key: controller.saveGlobleKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 600),
                                        Obx(() {
                                          return GestureDetector(
                                            onTap: controller.pickImage,
                                            child: Container(
                                              height: 250,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child:
                                                  controller.imageBytes.value ==
                                                      null
                                                  ? const Icon(
                                                      Icons
                                                          .upload_file_outlined,
                                                      size: 50,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      child: Image.memory(
                                                        controller
                                                            .imageBytes
                                                            .value!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                            ),
                                          );
                                        }),
                                        const SizedBox(height: 10),
                                        CustomTextFormFieldWidget(
                                          validator: (val) => inputValidation(
                                            1000,
                                            3,
                                            val!,
                                            'title',
                                          ),
                                          hintText: 'Titre',
                                          controller:
                                              controller.titleController,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormFieldWidget(
                                          validator: (val) => inputValidation(
                                            1000,
                                            3,
                                            val!,
                                            'Description',
                                          ),
                                          hintText: 'Description',
                                          controller:
                                              controller.descriptionController,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormFieldWidget(
                                          validator: (val) => inputValidation(
                                            200,
                                            3,
                                            val!,
                                            'location',
                                          ),
                                          hintText: 'Lieu',
                                          controller:
                                              controller.locationController,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextFormFieldWidget(
                                          validator: (val) => inputValidation(
                                            50,
                                            1,
                                            val!,
                                            'date',
                                          ),
                                          controller:
                                              controller.date1Controller,
                                          readOnly: true,
                                          hintText: 'Date de début',
                                          prefixIcon: Iconsax.calendar,
                                          onTap: () async {
                                            DateTime? result = await controller
                                                .selectDateTime(
                                                  context,
                                                  controller.date1Controller,
                                                );
                                            if (result != null) {
                                              controller.date1 = result;
                                              controller.update();
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                  controller.clearAllData();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withValues(alpha: 0.2),
                                                    border: Border.all(
                                                      color: Colors.red,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.cancel_outlined,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text('Annuler'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Obx(() {
                                                return GestureDetector(
                                                  onTap:
                                                      controller.isLoading.value
                                                      ? null
                                                      : controller.uploadData,
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.primary
                                                            .withValues(
                                                              alpha: 0.2,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              50,
                                                            ),
                                                      ),
                                                      child:
                                                          controller
                                                              .isLoading
                                                              .value
                                                          ? const SizedBox(
                                                              height: 22,
                                                              width: 22,
                                                              child: CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                      Color
                                                                    >(
                                                                      AppColors
                                                                          .primary,
                                                                    ),
                                                              ),
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Icon(
                                                                  Icons
                                                                      .file_upload,
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text('Ajouter'),
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
                                  ),
                                ),
                              );
                            },
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
                                  Text('Ajouter'),
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
                                title: 'Confirmer la suppression',
                                text:
                                    'Êtes-vous sûr de vouloir supprimer tout le calendrier de nettoyage ?',
                                showConfirmBtn: true,
                                showCancelBtn: true,
                                confirmBtnText: 'Supprimer',
                                cancelBtnText: 'Annuler',
                                confirmBtnColor: Colors.red,
                                onConfirmBtnTap: controller.deleteAllEvents,
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
                                  Text('Tout supprimer'),
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

              /// ❌ Vide
              if (events.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity, height: 100),
                    Lottie.asset(
                      AppImages.noNotificationsAnimation,
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Text('Vide', style: AppTextStyle.titleStyle),
                    const SizedBox(height: 8),
                    Text(
                      'Il n\'y a aucun événement',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.contentStyle,
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

              if (events.isNotEmpty)
                ListView.separated(
                  itemCount: events.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final snapshot = events[index];
                    final eventsData = EventsModel.fromMap(
                      snapshot.data(),
                      snapshot.id,
                    );

                    return CustomEventManagementCard(
                          eventsModel: eventsData,
                          controller: controller,
                          onTapEditButton: () {
                            controller.lastTilteController.text =
                                eventsData.title;
                            controller.lastDescriptionController.text =
                                eventsData.description;
                            controller.lastLocationController.text =
                                eventsData.location;
                            controller.date2Controller.text = HelperFunctions()
                                .formatFirestoreTimestamp(eventsData.eventDate);
                            controller.oldImageUrl = eventsData.imageUrl;
                            controller.oldEventDate = eventsData.eventDate;
                            controller.date2 = null;
                            controller.imageBytesForUpdate.value = null;

                            Get.defaultDialog(
                              title:
                                  'Modifier l\'événement', // تحديث الحدث -> Modifier l'événement
                              content: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 600),
                                    Obx(() {
                                      return GestureDetector(
                                        onTap: controller.pickImageForUpdate,
                                        child: Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child:
                                              controller
                                                      .imageBytesForUpdate
                                                      .value ==
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    eventsData.imageUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.memory(
                                                    controller
                                                        .imageBytesForUpdate
                                                        .value!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      );
                                    }),
                                    const SizedBox(height: 10),
                                    CustomTextFormFieldWidget(
                                      hintText: 'Titre',
                                      controller:
                                          controller.lastTilteController,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextFormFieldWidget(
                                      hintText: 'Description',
                                      controller:
                                          controller.lastDescriptionController,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextFormFieldWidget(
                                      hintText: 'Lieu',
                                      controller:
                                          controller.lastLocationController,
                                    ),
                                    const SizedBox(height: 10),
                                    CustomTextFormFieldWidget(
                                      controller: controller.date2Controller,
                                      readOnly: true,
                                      hintText:
                                          'Date de début', // Start date -> Date de début
                                      prefixIcon: Iconsax.calendar,
                                      onTap: () async {
                                        DateTime? result = await controller
                                            .selectDateTime(
                                              context,
                                              controller.date2Controller,
                                            );
                                        if (result != null) {
                                          controller.date2 = result;
                                          controller.update();
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.red.withValues(
                                                  alpha: 0.2,
                                                ),
                                                border: Border.all(
                                                  color: Colors.red,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.cancel_outlined),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    'Annuler',
                                                  ), // Cancel -> Annuler
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Obx(() {
                                            return GestureDetector(
                                              onTap: () {
                                                final bool titleChanged =
                                                    controller
                                                        .lastTilteController
                                                        .text !=
                                                    eventsData.title;
                                                final bool descriptionChanged =
                                                    controller
                                                        .lastDescriptionController
                                                        .text !=
                                                    eventsData.description;
                                                final bool locationChanged =
                                                    controller
                                                        .lastLocationController
                                                        .text !=
                                                    eventsData.location;
                                                final bool dateChanged =
                                                    controller.date2 != null;
                                                final bool imageChanged =
                                                    controller
                                                        .imageBytesForUpdate
                                                        .value !=
                                                    null;

                                                final bool hasChanges =
                                                    titleChanged ||
                                                    descriptionChanged ||
                                                    locationChanged ||
                                                    dateChanged ||
                                                    imageChanged;

                                                if (hasChanges) {
                                                  controller.updateEvent(
                                                    eventsData.id,
                                                  );
                                                } else {
                                                  Get.snackbar(
                                                    'Attention', // Warning -> Attention
                                                    'Aucune modification détectée par rapport aux données précédentes.', // الرسالة التحذيرية بالفرنسية
                                                  );
                                                }
                                              },
                                              child: SizedBox(
                                                height: 45,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary
                                                        .withValues(alpha: 0.2),
                                                    border: Border.all(
                                                      color: AppColors.primary,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                  ),
                                                  child:
                                                      controller
                                                          .isLoadingForUpdate
                                                          .value
                                                      ? const SizedBox(
                                                          height: 22,
                                                          width: 22,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                  Color
                                                                >(
                                                                  AppColors
                                                                      .primary,
                                                                ),
                                                          ),
                                                        )
                                                      : const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.file_upload,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Mettre à jour',
                                                            ), // Update Event -> Mettre à jour
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
                              ),
                            );
                          },
                        )
                        .animate()
                        .fadeIn(delay: (200 + index * 100).ms, duration: 600.ms)
                        .slideY(
                          begin: 0.2,
                          delay: (200 + index * 100).ms,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

class CustomEventManagementCard extends StatelessWidget {
  final EventsModel eventsModel;
  final EventsManagementControllerImp controller;
  final void Function()? onTapEditButton;

  const CustomEventManagementCard({
    super.key,
    required this.eventsModel,
    required this.controller,
    this.onTapEditButton,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (eventsModel.imageUrl != '')
            ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        eventsModel.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,

                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: isDarkMode
                                ? Colors.grey.shade900
                                : Colors.grey.shade100,
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                        // يمكنك أيضاً إضافة معالج للأخطاء في حال فشل تحميل الصورة
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                      children: [
                        Expanded(
                          child: Text(
                            eventsModel.title,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onTapEditButton,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Iconsax.edit),
                          ),
                        ),
                        const SizedBox(width: 7),
                        GestureDetector(
                          onTap: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Confirmer la suppression', // تأكيد الحذف
                              text:
                                  'Êtes-vous sûr de vouloir supprimer cet événement ?', // هل أنت متأكد؟
                              showConfirmBtn: true,
                              showCancelBtn: true,
                              confirmBtnText: 'Supprimer', // حذف
                              cancelBtnText: 'Annuler', // إلغاء
                              confirmBtnColor: Colors.red,
                              onConfirmBtnTap: () {
                                controller.deleteOneEvent(eventsModel.id);
                              },
                              onCancelBtnTap: () {
                                Get.back();
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.2),
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.delete_outline_outlined),
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 100.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 12),

                // Description
                Text(
                      eventsModel.description,
                      style: TextStyle(
                        color: Colors.grey[isDarkMode ? 400 : 600],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 16),

                // Badges Row (Time + Location)
                Wrap(
                  runSpacing: 10,
                  children: [
                    // Time Badge
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.clock,
                                color: AppColors.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                HelperFunctions().formatFirestoreTimestamp(
                                  eventsModel.eventDate,
                                ),
                                style: TextStyle(
                                  color: Colors.grey[isDarkMode ? 400 : 600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 300.ms)
                        .slideX(begin: -0.2, end: 0),

                    const SizedBox(width: 8),

                    // Location Badge
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.location,
                                color: AppColors.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                eventsModel.location,
                                style: TextStyle(
                                  color: Colors.grey[isDarkMode ? 400 : 600],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 350.ms)
                        .slideX(begin: -0.2, end: 0),
                  ],
                ),

                const SizedBox(height: 20),

                if (eventsModel.registrants.isNotEmpty)
                  Column(
                    children: [
                      Row(
                            children: [
                              const Text(
                                'Membres inscrits', // الأعضاء المسجلين
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_downward_sharp,
                                color: AppColors.primary,
                                size: 16,
                              ),
                            ],
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 400.ms)
                          .slideX(begin: -0.2, end: 0),
                      const SizedBox(height: 20),
                      ListView.separated(
                        itemCount: eventsModel.registrants.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(eventsModel.registrants[index])
                                .get(),
                            builder: (context, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!userSnapshot.hasData ||
                                  !userSnapshot.data!.exists) {
                                return const Text('Utilisateur introuvable');
                              }

                              final userData =
                                  userSnapshot.data!.data()
                                      as Map<String, dynamic>;
                              UserModel userModel = UserModel.fromMap(
                                userData,
                                eventsModel.registrants[index],
                              );
                              return CustomShowEventMembersCard(
                                userModel: userModel,
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShowEventMembersCard extends StatelessWidget {
  final UserModel userModel;

  const CustomShowEventMembersCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDarkMode)
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الجزء العلوي: الصورة والبيانات الأساسية
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. الصورة الشخصية
              Hero(
                tag: userModel.id,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: userModel.isActive
                      ? AppColors.primary.withValues(alpha: 0.8)
                      : Colors.red.shade900,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: userModel.imageUrl.isEmpty
                        ? SvgPicture.asset(
                            AppImages.avatar,
                            width: 56,
                            height: 56,
                          )
                        : Image.network(
                            userModel.imageUrl,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                SvgPicture.asset(AppImages.avatar),
                          ),
                  ),
                ),
              ).animate().fadeIn().scale(),

              const SizedBox(width: 15),

              // 2. الاسم والايميل (استخدام Expanded هنا ضروري لمنع الـ Overflow)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            userModel.username,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildStatusBadge(userModel.isActive),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userModel.email,
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 3. التاجات (التاريخ ورقم الغرفة) - نضعها خارج الـ Row العلوي
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfoTag(
                icon: Iconsax.calendar,
                label: HelperFunctions().formatFirestoreTimestamp(
                  userModel.createdAt,
                ),
                isDarkMode: isDarkMode,
              ),
              _buildInfoTag(
                icon: Iconsax.home,
                label: 'Chambre: ${userModel.roomNumber}',
                isDarkMode: isDarkMode,
              ),
            ],
          ).animate().fadeIn(delay: 400.ms),
        ],
      ),
    ).animate().slideX(begin: 0.1, duration: 400.ms).fadeIn();
  }

  
  Widget _buildInfoTag({
    required IconData icon,
    required String label,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.grey[100],
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  
  Widget _buildStatusBadge(bool isActive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),

      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha:0.1)
            : Colors.red.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isActive ? AppColors.primary : Colors.red,
          width: 0.5,
        ),
      ),
      child: Text(
        isActive ? 'Actif' : 'Inactif',
        style: TextStyle(
          color: Colors.white,
          
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// onTapEditButton: () {
//                           controller.lastTilteController.text =
//                               eventsData.title;
//                           controller.lastDescriptionController.text =
//                               eventsData.description;
//                           controller.lastLocationController.text =
//                               eventsData.location;
//                           controller.date2Controller.text = HelperFunctions()
//                               .formatFirestoreTimestamp(eventsData.eventDate);
//                           controller.oldImageUrl = eventsData.imageUrl;
//                           controller.oldEventDate = eventsData.eventDate;
//                           controller.date2 = null;
//                           controller.imageBytesForUpdate.value = null;
//                           Get.defaultDialog(
//                             title: 'Update Event',
//                             content: Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SizedBox(width: 600),
//                                   Obx(() {
//                                     return GestureDetector(
//                                       onTap: controller.pickImageForUpdate,
//                                       child: Container(
//                                         height: 250,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.grey,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             8,
//                                           ),
//                                         ),
//                                         child:
//                                             controller
//                                                     .imageBytesForUpdate
//                                                     .value ==
//                                                 null
//                                             ? const Icon(
//                                                 Icons.upload_file_outlined,
//                                                 size: 50,
//                                               )
//                                             : ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                                 child: Image.memory(
//                                                   controller
//                                                       .imageBytesForUpdate
//                                                       .value!,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                       ),
//                                     );
//                                   }),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Title',
//                                     controller: controller.lastTilteController,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Description',
//                                     controller:
//                                         controller.lastDescriptionController,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Location',
//                                     controller:
//                                         controller.lastLocationController,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     controller: controller.date2Controller,
//                                     readOnly: true,
//                                     hintText: 'Start date',
//                                     prefixIcon: Iconsax.calendar,
//                                     onTap: () async {
//                                       DateTime? result = await controller
//                                           .selectDateTime(
//                                             context,
//                                             controller.date2Controller,
//                                           );
//                                       if (result != null) {
//                                         controller.date2 = result;
//                                         controller.update();
//                                       }
//                                     },
//                                   ),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                         child: GestureDetector(
//                                           onTap: () => Get.back(),
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: 20,
//                                               vertical: 10,
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: Colors.red.withValues(
//                                                 alpha: 0.2,
//                                               ),
//                                               border: Border.all(
//                                                 color: Colors.red,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(50),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Icon(Icons.cancel_outlined),
//                                                 SizedBox(width: 5),
//                                                 Text('Cancle'),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 20),
//                                       Expanded(
//                                         child: Obx(() {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               final bool titleChanged =
//                                                   controller
//                                                       .lastTilteController
//                                                       .text !=
//                                                   eventsData.title;
//                                               final bool descriptionChanged =
//                                                   controller
//                                                       .lastDescriptionController
//                                                       .text !=
//                                                   eventsData.description;
//                                               final bool locationChanged =
//                                                   controller
//                                                       .lastLocationController
//                                                       .text !=
//                                                   eventsData.location;
//                                               final bool dateChanged =
//                                                   controller.date2 != null;
//                                               final bool imageChanged =
//                                                   controller
//                                                       .imageBytesForUpdate
//                                                       .value !=
//                                                   null;
//                                               final bool hasChanges =
//                                                   titleChanged ||
//                                                   descriptionChanged ||
//                                                   locationChanged ||
//                                                   dateChanged ||
//                                                   imageChanged;
//                                               if (hasChanges) {
//                                                 controller.updateEvent(
//                                                   eventsData.id,
//                                                 );
//                                               } else {
//                                                 Get.snackbar(
//                                                   'Warning',
//                                                   'There is no difference from the previous data.',
//                                                 );
//                                               }
//                                             },
//                                             child: SizedBox(
//                                               height: 45,
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   color: AppColors.primary
//                                                       .withValues(alpha: 0.2),
//                                                   border: Border.all(
//                                                     color: AppColors.primary,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(50),
//                                                 ),
//                                                 child:
//                                                     controller
//                                                         .isLoadingForUpdate
//                                                         .value
//                                                     ? SizedBox(
//                                                         height: 22,
//                                                         width: 22,
//                                                         child: CircularProgressIndicator(
//                                                           strokeWidth: 2,
//                                                           valueColor:
//                                                               AlwaysStoppedAnimation<
//                                                                 Color
//                                                               >(
//                                                                 AppColors
//                                                                     .primary,
//                                                               ),
//                                                         ),
//                                                       )
//                                                     : Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Icon(
//                                                             Icons.file_upload,
//                                                           ),
//                                                           SizedBox(width: 5),
//                                                           Text('Update Event'),
//                                                         ],
//                                                       ),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
// class EventManagementView extends GetView<EventsManagementControllerImp> {
//   const EventManagementView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => EventsManagementControllerImp(), fenix: true);
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: ListView(
//         children: [
//           SizedBox(height: 40),
//           Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Manage Events',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Get.defaultDialog(
//                         title: 'Create Event',
//                         content: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SizedBox(width: 600),
//                               Obx(() {
//                                 return GestureDetector(
//                                   onTap: controller.pickImage,
//                                   child: Container(
//                                     height: 250,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: controller.imageBytes.value == null
//                                         ? const Icon(
//                                             Icons.upload_file_outlined,
//                                             size: 50,
//                                           )
//                                         : ClipRRect(
//                                             borderRadius: BorderRadius.circular(
//                                               8,
//                                             ),
//                                             child: Image.memory(
//                                               controller.imageBytes.value!,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                   ),
//                                 );
//                               }),
//                               const SizedBox(height: 10),
//                               CustomTextFormFieldWidget(
//                                 hintText: 'Title',
//                                 controller: controller.titleController,
//                               ),
//                               const SizedBox(height: 10),
//                               CustomTextFormFieldWidget(
//                                 hintText: 'Description',
//                                 controller: controller.descriptionController,
//                               ),
//                               const SizedBox(height: 10),
//                               CustomTextFormFieldWidget(
//                                 hintText: 'Location',
//                                 controller: controller.locationController,
//                               ),
//                               const SizedBox(height: 10),
//                               CustomTextFormFieldWidget(
//                                 controller: controller.date1Controller,
//                                 readOnly: true,
//                                 hintText: 'Start date',
//                                 prefixIcon: Iconsax.calendar,
//                                 onTap: () async {
//                                   DateTime? result = await controller
//                                       .selectDateTime(
//                                         context,
//                                         controller.date1Controller,
//                                       );
//                                   if (result != null) {
//                                     controller.date1 = result;
//                                     controller.update();
//                                   }
//                                 },
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Get.back();
//                                         controller.clearAllData();
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 20,
//                                           vertical: 10,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.red.withValues(
//                                             alpha: 0.2,
//                                           ),
//                                           border: Border.all(color: Colors.red),
//                                           borderRadius: BorderRadius.circular(
//                                             50,
//                                           ),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Icon(Icons.cancel_outlined),
//                                             SizedBox(width: 5),
//                                             Text('Cancle'),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 20),
//                                   Expanded(
//                                     child: Obx(() {
//                                       return GestureDetector(
//                                         onTap: controller.isLoading.value
//                                             ? null
//                                             : controller.uploadData,
//                                         child: SizedBox(
//                                           height: 45,
//                                           child: Container(
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               color: AppColors.primary
//                                                   .withValues(alpha: 0.2),
//                                               border: Border.all(
//                                                 color: AppColors.primary,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(50),
//                                             ),
//                                             child: controller.isLoading.value
//                                                 ? SizedBox(
//                                                     height: 22,
//                                                     width: 22,
//                                                     child: CircularProgressIndicator(
//                                                       strokeWidth: 2,
//                                                       valueColor:
//                                                           AlwaysStoppedAnimation<
//                                                             Color
//                                                           >(AppColors.primary),
//                                                     ),
//                                                   )
//                                                 : Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(Icons.file_upload),
//                                                       SizedBox(width: 5),
//                                                       Text('Add Event'),
//                                                     ],
//                                                   ),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.primary.withValues(alpha: 0.2),
//                         border: Border.all(color: AppColors.primary),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Row(
//                         children: [Icon(Iconsax.add), Text('Add Event')],
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       QuickAlert.show(
//                         context: context,
//                         type: QuickAlertType.error,
//                         title: 'Confirm deletion',
//                         text: 'Are you sure you\'ve deleted all the events?',
//                         showConfirmBtn: true,
//                         showCancelBtn: true,
//                         confirmBtnText: 'Delete',
//                         cancelBtnText: 'Cancle',
//                         confirmBtnColor: Colors.red,
//                         onConfirmBtnTap: () {
//                           controller.deleteAllEvents();
//                         },
//                         onCancelBtnTap: () {
//                           Get.back();
//                         },
//                       );
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.red.withValues(alpha: 0.2),
//                         border: Border.all(color: Colors.red),
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.delete_outline_outlined),
//                           Text('Delete All'),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//               .animate()
//               .fadeIn(delay: 600.ms, duration: 600.ms)
//               .slideY(
//                 begin: 0.2,
//                 delay: 600.ms,
//                 duration: 600.ms,
//                 curve: Curves.easeOut,
//               ),
//           SizedBox(height: 20),
//           StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('events')
//                 .orderBy('eventDate')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: double.infinity, height: 100),
//                     SvgPicture.asset(AppImages.errorGetData, height: 250),
//                     const SizedBox(height: 20),
//                     Text(
//                       'cleaningScheduleErrorGetDataTitle'.tr,
//                       style: AppTextStyle.titleStyle,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'cleaningScheduleErrorGetDataContent'.tr,
//                       textAlign: TextAlign.center,
//                       style: AppTextStyle.contentStyle,
//                     ),
//                   ],
//                 );
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CustomLoadingCircular();
//               }
//               if (snapshot.data!.docs.isEmpty) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: double.infinity, height: 100),
//                     Lottie.asset(
//                       AppImages.noNotificationsAnimation,
//                       height: 250,
//                     ),
//                     const SizedBox(height: 20),
//                     Text('Empty', style: AppTextStyle.titleStyle),
//                     const SizedBox(height: 8),
//                     Text(
//                       'There is no events',
//                       textAlign: TextAlign.center,
//                       style: AppTextStyle.contentStyle,
//                     ),
//                   ],
//                 ).animate().fadeIn(delay: 600.ms, duration: 600.ms);
//               }
//               return ListView.separated(
//                 itemCount: snapshot.data!.docs.length,
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final enventsSnaphote = snapshot.data!.docs[index];
//                   final eventsData = EventsModel.fromMap(
//                     enventsSnaphote.data(),
//                     enventsSnaphote.id,
//                   );
//                   return CustomEventManagementCard(
//                         eventsModel: eventsData,
//                         controller: controller,
//                         onTapEditButton: () {
//                           controller.lastTilteController.text =
//                               eventsData.title;
//                           controller.lastDescriptionController.text =
//                               eventsData.description;
//                           controller.lastLocationController.text =
//                               eventsData.location;
//                           controller.date2Controller.text = HelperFunctions()
//                               .formatFirestoreTimestamp(eventsData.eventDate);
//                           controller.oldImageUrl = eventsData.imageUrl;
//                           controller.oldEventDate = eventsData.eventDate;
//                           controller.date2 = null;
//                           controller.imageBytesForUpdate.value = null;
//                           Get.defaultDialog(
//                             title: 'Update Event',
//                             content: Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SizedBox(width: 600),
//                                   Obx(() {
//                                     return GestureDetector(
//                                       onTap: controller.pickImageForUpdate,
//                                       child: Container(
//                                         height: 250,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.grey,
//                                           ),
//                                           borderRadius: BorderRadius.circular(
//                                             8,
//                                           ),
//                                         ),
//                                         child:
//                                             controller
//                                                     .imageBytesForUpdate
//                                                     .value ==
//                                                 null
//                                             ? const Icon(
//                                                 Icons.upload_file_outlined,
//                                                 size: 50,
//                                               )
//                                             : ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                                 child: Image.memory(
//                                                   controller
//                                                       .imageBytesForUpdate
//                                                       .value!,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                       ),
//                                     );
//                                   }),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Title',
//                                     controller: controller.lastTilteController,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Description',
//                                     controller:
//                                         controller.lastDescriptionController,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Location',
//                                     controller:
//                                         controller.lastLocationController,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   CustomTextFormFieldWidget(
//                                     controller: controller.date2Controller,
//                                     readOnly: true,
//                                     hintText: 'Start date',
//                                     prefixIcon: Iconsax.calendar,
//                                     onTap: () async {
//                                       DateTime? result = await controller
//                                           .selectDateTime(
//                                             context,
//                                             controller.date2Controller,
//                                           );
//                                       if (result != null) {
//                                         controller.date2 = result;
//                                         controller.update();
//                                       }
//                                     },
//                                   ),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Expanded(
//                                         child: GestureDetector(
//                                           onTap: () => Get.back(),
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: 20,
//                                               vertical: 10,
//                                             ),
//                                             decoration: BoxDecoration(
//                                               color: Colors.red.withValues(
//                                                 alpha: 0.2,
//                                               ),
//                                               border: Border.all(
//                                                 color: Colors.red,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(50),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Icon(Icons.cancel_outlined),
//                                                 SizedBox(width: 5),
//                                                 Text('Cancle'),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 20),
//                                       Expanded(
//                                         child: Obx(() {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               final bool titleChanged =
//                                                   controller
//                                                       .lastTilteController
//                                                       .text !=
//                                                   eventsData.title;
//                                               final bool descriptionChanged =
//                                                   controller
//                                                       .lastDescriptionController
//                                                       .text !=
//                                                   eventsData.description;
//                                               final bool locationChanged =
//                                                   controller
//                                                       .lastLocationController
//                                                       .text !=
//                                                   eventsData.location;
//                                               final bool dateChanged =
//                                                   controller.date2 != null;
//                                               final bool imageChanged =
//                                                   controller
//                                                       .imageBytesForUpdate
//                                                       .value !=
//                                                   null;
//                                               final bool hasChanges =
//                                                   titleChanged ||
//                                                   descriptionChanged ||
//                                                   locationChanged ||
//                                                   dateChanged ||
//                                                   imageChanged;
//                                               if (hasChanges) {
//                                                 controller.updateEvent(
//                                                   eventsData.id,
//                                                 );
//                                               } else {
//                                                 Get.snackbar(
//                                                   'Warning',
//                                                   'There is no difference from the previous data.',
//                                                 );
//                                               }
//                                             },
//                                             child: SizedBox(
//                                               height: 45,
//                                               child: Container(
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                   color: AppColors.primary
//                                                       .withValues(alpha: 0.2),
//                                                   border: Border.all(
//                                                     color: AppColors.primary,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(50),
//                                                 ),
//                                                 child:
//                                                     controller
//                                                         .isLoadingForUpdate
//                                                         .value
//                                                     ? SizedBox(
//                                                         height: 22,
//                                                         width: 22,
//                                                         child: CircularProgressIndicator(
//                                                           strokeWidth: 2,
//                                                           valueColor:
//                                                               AlwaysStoppedAnimation<
//                                                                 Color
//                                                               >(
//                                                                 AppColors
//                                                                     .primary,
//                                                               ),
//                                                         ),
//                                                       )
//                                                     : Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Icon(
//                                                             Icons.file_upload,
//                                                           ),
//                                                           SizedBox(width: 5),
//                                                           Text('Update Event'),
//                                                         ],
//                                                       ),
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                       .animate()
//                       .fadeIn(delay: (200 + index * 100).ms, duration: 600.ms)
//                       .slideY(
//                         begin: 0.2,
//                         delay: (200 + index * 100).ms,
//                         duration: 600.ms,
//                         curve: Curves.easeOut,
//                       )
//                       .then(delay: 500.ms);
//                 },
//                 separatorBuilder: (context, index) => SizedBox(height: 20),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
