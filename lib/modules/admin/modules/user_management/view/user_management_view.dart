import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/functions/input_validation.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/global/custom_normal_button.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:chimay_house/modules/admin/modules/account_activation/view/account_activation_view.dart';
import 'package:chimay_house/modules/admin/modules/user_management/controller/user_management_controller.getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

class UserManagementView extends GetView<UserManagementControllerImp> {
  const UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserManagementControllerImp(), fenix: true);
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'user')
            .orderBy('roomNumber')
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
                                  'Gestion des utilisateurs',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'G\u00e9rer et surveiller tous les utilisateurs',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withValues(alpha: 0.7),
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
                              Iconsax.people,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
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
                              '$count    Total Utilisateurs',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .slideY(
                    begin: -0.1,
                    duration: 1000.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 16),

              if (snapshot.hasError)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: double.infinity, height: 100),
                    SvgPicture.asset(AppImages.errorGetData, height: 250),
                    const SizedBox(height: 20),
                    Text('Erreur', style: AppTextStyle.titleStyle),
                    const SizedBox(height: 8),
                    Text(
                      'Erreur lors de la r\u00e9cup\u00e9ration des utilisateurs',
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
                    SizedBox(width: double.infinity, height: 100),
                    Lottie.asset(
                      AppImages.noNotificationsAnimation,
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Text('Vide', style: AppTextStyle.titleStyle),
                    const SizedBox(height: 8),
                    Text(
                      'Il n\'y a pas de nouveaux utilisateurs',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.contentStyle,
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms)
              else
                ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    UserModel userModel = UserModel.fromMap(
                      data.data(),
                      data.id,
                    );

                    return CustomManageUserDate(
                      userModel: userModel,
                      onTapDeleteUser: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Confirmer la suppression',
                          text:
                              '\u00cates-vous s\u00fbr de vouloir supprimer d\u00e9finitivement cet utilisateur ?',
                          showConfirmBtn: true,
                          showCancelBtn: true,
                          confirmBtnText: 'Supprimer',
                          cancelBtnText: 'Annuler',
                          confirmBtnColor: Colors.red,
                          onConfirmBtnTap: () async{
                            Get.back();
                            AdminService.deleteUser(userModel.id);
                          },
                          onCancelBtnTap: () => Get.back(),
                        );
                      },
                      onTapEditUser: () {
                        controller.usernameController.text = userModel.username;
                        controller.roomNumber.text = userModel.roomNumber
                            .toString();
                        controller.isActive = userModel.isActive;

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Form(
                              key: controller.globalKey,
                              child: AlertDialog(
                                content: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Iconsax.user_edit,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                          const SizedBox(width: 12),
                                          const Expanded(
                                            child: Text(
                                              'Modifier l\'utilisateur',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 400, height: 20),
                                      CustomTextFormFieldWidget(
                                        validator: (val) => inputValidation(
                                          100,
                                          2,
                                          val!,
                                          'name',
                                        ),
                                        hintText: 'Nom d\'utilisateur',
                                        controller:
                                            controller.usernameController,
                                      ),
                                      SizedBox(height: 20),
                                      CustomTextFormFieldWidget(
                                        validator: (val) =>
                                            inputValidation(3, 1, val!, 'room'),
                                        hintText: 'Num\u00e9ro de chambre',
                                        controller: controller.roomNumber,
                                      ),
                                      SizedBox(height: 20),
                                      GetBuilder<UserManagementControllerImp>(
                                        builder: (myController) {
                                          final isActiveColor =
                                              controller.isActive
                                              ? AppColors.primary
                                              : Colors.red;
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: isActiveColor.withValues(
                                                  alpha: 0.3,
                                                ),
                                                width: 1.5,
                                              ),
                                              color: isActiveColor.withValues(
                                                alpha: 0.05,
                                              ),
                                            ),
                                            child: CheckboxListTile(
                                              activeColor: AppColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              title: Text(
                                                'Compte actif',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: controller.isActive
                                                      ? AppColors.primary
                                                      : Colors.red,
                                                ),
                                              ),
                                              subtitle: Text(
                                                controller.isActive
                                                    ? 'L\'utilisateur peut acc\u00e9der \u00e0 l\'application'
                                                    : 'L\'acc\u00e8s de l\'utilisateur est restreint',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: isDarkMode
                                                      ? Colors.grey[400]
                                                      : Colors.grey[600],
                                                ),
                                              ),
                                              value: controller.isActive,
                                              onChanged: (val) {
                                                controller.isActive = val!;
                                                controller.update();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(height: 40),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () => Get.back(),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
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
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.cancel_outlined),
                                                    SizedBox(width: 5),
                                                    Text('Annuler'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Obx(() {
                                              return GestureDetector(
                                                onTap: () {
                                                  bool isSameName =
                                                      controller
                                                          .usernameController
                                                          .text ==
                                                      userModel.username;
                                                  bool isSameRoomNumber =
                                                      int.parse(
                                                        controller
                                                            .roomNumber
                                                            .text,
                                                      ) ==
                                                      userModel.roomNumber;
                                                  bool isSameActivationStatus =
                                                      controller.isActive ==
                                                      userModel.isActive;

                                                  if (isSameName &&
                                                      isSameRoomNumber &&
                                                      isSameActivationStatus) {
                                                    Get.snackbar(
                                                      'Attention',
                                                      'Assurez-vous d\'avoir effectu\u00e9 des modifications avant d\'enregistrer',
                                                    );
                                                  } else {
                                                    controller.onSaveNewData(
                                                      userModel.id,
                                                    );
                                                  }
                                                },
                                                child: SizedBox(
                                                  height: 45,
                                                  child: Container(
                                                    alignment: Alignment.center,
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
                                                        ? SizedBox(
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
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .check_circle_outline,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                'Enregistrer',
                                                              ),
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
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => SizedBox(height: 10),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CustomManageUserDate extends StatelessWidget {
  final UserModel userModel;
  final void Function()? onTapEditUser;
  final void Function()? onTapDeleteUser;
  const CustomManageUserDate({
    super.key,
    required this.userModel,
    this.onTapEditUser,
    this.onTapDeleteUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[isDarkMode ? 900 : 300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                        radius: 24,
                        backgroundColor: userModel.isActive == true
                            ? AppColors.primary.withValues(alpha: 0.8)
                            : Colors.red.shade900,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: userModel.imageUrl == ''
                              ? SvgPicture.asset(
                                  AppImages.avatar,
                                  width: 48,
                                  height: 48,
                                )
                              : Image.network(
                                  userModel.imageUrl,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,

                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primary,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    log(error.toString());
                                    return SvgPicture.asset(AppImages.avatar);
                                  },
                                ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .slideY(begin: 0.2, duration: 400.ms),
                      
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                  userModel.username,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: AppFontsSize.smallFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 400.ms, duration: 400.ms)
                                .slideY(begin: 0.2, duration: 400.ms),
                            if (!userModel.isActive)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Text(
                                  'Inactif',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                            if (userModel.isActive)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: AppColors.primary),
                                ),
                                child: Text(
                                  'Actif',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                              userModel.email,
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey[300]
                                    : Colors.grey[700],
                                fontSize: AppFontsSize.extraSmallFontSize,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 500.ms, duration: 400.ms)
                            .slideY(begin: 0.2, duration: 400.ms),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: onTapEditUser,
                              icon: Icon(Iconsax.edit),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 400.ms)
                          .slideY(begin: 0.2, duration: 400.ms),
                      SizedBox(width: 20),
                      Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: onTapDeleteUser,
                              icon: Icon(Icons.delete_outline_outlined),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 700.ms, duration: 400.ms)
                          .slideY(begin: 0.2, duration: 400.ms),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.09)
                              : Colors.grey[100],
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Iconsax.calendar,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              HelperFunctions().formatFirestoreTimestamp(
                                userModel.createdAt,
                              ),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 400.ms)
                      .slideY(begin: 0.2, duration: 400.ms),
                  Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.09)
                              : Colors.grey[100],
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.home, color: AppColors.primary, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Chambre: ${userModel.roomNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 400.ms)
                      .slideY(begin: 0.2, duration: 400.ms),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 400.ms)
        .slideY(begin: 0.2, duration: 400.ms);
  }
}
