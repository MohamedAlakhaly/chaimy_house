import 'dart:developer';

import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/edit_personal_detailes/controller/edit_personal_detailes_controller.getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class EditPersonalDetailesView extends StatelessWidget {
  final UserModel userModel;
  const EditPersonalDetailesView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    String formatFirestoreTimestampOnlyDateWithNormalStyle(
      Timestamp timestamp,
    ) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat("dd / MM / y").format(dateTime);
    }

    EditPersonalDetailesControllerImp controller = Get.put(
      EditPersonalDetailesControllerImp(),
    );
    controller.nameController.text = userModel.username;
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'editPersonalDetailesAppBarTitle'.tr,
        actions: [
          GetBuilder<EditPersonalDetailesControllerImp>(
            builder: (myController) {
              return GestureDetector(
                onTap: () {
                  if (controller.nameController.text != userModel.username ||
                      controller.pickedImage != null) {
                    controller.updateProfile();
                    log('true');
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        (controller.nameController.text == userModel.username &&
                            controller.pickedImage == null)
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'saveButton'.tr,
                    style: TextStyle(
                      color:
                          controller.nameController.text == userModel.username
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GetBuilder<EditPersonalDetailesControllerImp>(
                builder: (controller) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.2,
                        ),
                        child: ClipOval(child: _buildProfileImage(controller)),
                      ),

                      if (controller.isLoading)
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller
                              .pickImage(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              border: Border.all(
                                color: isDarkMode
                                    ? AppColors.bgDark
                                    : AppColors.bgLight,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Iconsax.image,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(
                      begin: -0.2,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    );
                },
              ),
              SizedBox(width: double.infinity, height: 20),
              CustomTextFormFieldWidget(
                hintText: 'username'.tr,
                prefixIcon: Icons.person_2_outlined,
                controller: controller.nameController,
                onChanged: (val) {
                  controller.update();
                },
              ).animate()
                    .fadeIn(duration: 700.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 700.ms,
                      curve: Curves.easeOut,
                    ),
              SizedBox(width: double.infinity, height: 20),
              CustomTextFormFieldWidget(
                prefixIcon: Icons.email_outlined,
                hintText: userModel.email,
                enabled: false,
              ).animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    ),
              SizedBox(width: double.infinity, height: 20),
              CustomTextFormFieldWidget(
                hintText: formatFirestoreTimestampOnlyDateWithNormalStyle(
                  userModel.createdAt,
                ),
                prefixIcon: Iconsax.calendar,
                enabled: false,
              ).animate()
                    .fadeIn(duration: 900.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 900.ms,
                      curve: Curves.easeOut,
                    ),
              SizedBox(width: double.infinity, height: 20),
              CustomTextFormFieldWidget(
                hintText: userModel.roomNumber.toString(),
                prefixIcon: Iconsax.home,
                enabled: false,
              ).animate()
                    .fadeIn(duration: 1000.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 1000.ms,
                      curve: Curves.easeOut,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(EditPersonalDetailesControllerImp controller) {
    if (controller.pickedImage != null) {
      return Image.file(
        controller.pickedImage!,
        width: 140,
        height: 140,
        fit: BoxFit.cover,
      );
    }

    if (userModel.imageUrl.isNotEmpty) {
      return Image.network(
        userModel.imageUrl,
        width: 140,
        height: 140,
        fit: BoxFit.cover,

        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) =>
            SvgPicture.asset(AppImages.avatar),
      );
    }

    return SvgPicture.asset(AppImages.avatar, width: 140, height: 140);
  }
}
