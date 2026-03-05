import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:chimay_house/modules/admin/modules/account_activation/controller/account_activation_controller.getx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

class AccountActivationView extends GetView<AccountActivationControllerImp> {
  const AccountActivationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AccountActivationControllerImp(), fenix: true);

    final usersStream = FirebaseFirestore.instance
        .collection('users')
        .where('isActive', isEqualTo: false)
        .where('role', isEqualTo: 'user')
        .snapshots();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity, height: 100),
                SvgPicture.asset(AppImages.errorGetData, height: 250),
                const SizedBox(height: 20),
                Text(
                  'Erreur',
                  style: AppTextStyle.titleStyle,
                ), // Error -> Erreur
                const SizedBox(height: 8),
                Text(
                  'Erreur lors de la récupération des utilisateurs', // Error get user -> Erreur lors de la récupération...
                  textAlign: TextAlign.center,
                  style: AppTextStyle.contentStyle,
                ),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingCircular();
          }

          final users = snapshot.data!.docs;
          final count = users.length;

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
                                  'Activation de Compte', // Account Activation -> Activation de Compte
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Vérifiez et activez les comptes utilisateurs en attente.', // Review and activate...
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
                              Icons.person_outline,
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
                              '$count   Total Utilisateurs', // Total Users -> Total Utilisateurs
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
              const SizedBox(height: 20),
              if (users.isEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: double.infinity, height: 100),
                    Lottie.asset(
                      AppImages.noNotificationsAnimation,
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Vide',
                      style: AppTextStyle.titleStyle,
                    ), // Empty -> Vide
                    const SizedBox(height: 8),
                    Text(
                      'Il n\'y a pas de nouveaux utilisateurs', // There is no new users -> Il n'y a pas de nouveaux...
                      textAlign: TextAlign.center,
                      style: AppTextStyle.contentStyle,
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
              if (users.isNotEmpty)
                ListView.separated(
                  itemCount: users.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = users[index];
                    final userModel = UserModel.fromMap(data.data(), data.id);

                    return CustomActivationUserCard(
                          userModel: userModel,
                          onTapAcceptUser: () {
                            controller.acceptUser(data.id);
                          },
                          onTapDeleteUser: () {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title:
                                  'Confirmer la suppression', // Confirm deletion -> Confirmer la suppression
                              text:
                                  'Êtes-vous sûr de ne pas vouloir inscrire cet utilisateur ?', // Are you sure... -> Êtes-vous sûr...
                              showConfirmBtn: true,
                              showCancelBtn: true,
                              confirmBtnText:
                                  'Supprimer', // Delete -> Supprimer
                              cancelBtnText: 'Annuler', // Cancle -> Annuler
                              confirmBtnColor: Colors.red,
                              onConfirmBtnTap: () {
                                Get.back();
                                AdminService.deleteUser(userModel.id);
                              },
                              onCancelBtnTap: () {
                                Get.back();
                              },
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

class CustomActivationUserCard extends StatelessWidget {
  final UserModel userModel;
  final void Function()? onTapAcceptUser;
  final void Function()? onTapDeleteUser;
  const CustomActivationUserCard({
    super.key,
    required this.userModel,
    this.onTapAcceptUser,
    this.onTapDeleteUser,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Container(
          padding: const EdgeInsets.all(10),
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
                        backgroundColor: Colors.red[900],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: userModel.imageUrl == ''
                              ? SvgPicture.asset(
                                  AppImages.avatar,
                                  width: 140,
                                  height: 140,
                                )
                              : Image.network(
                                  userModel.imageUrl,
                                  width: 140,
                                  height: 140,
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
                                  errorBuilder: (context, error, stackTrace) =>
                                      SvgPicture.asset(AppImages.avatar),
                                ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .slideY(begin: 0.2, duration: 400.ms),
                  const SizedBox(width: 20),
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
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Text(
                                    'Inactif',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 400.ms)
                            .slideY(begin: 0.2, duration: 400.ms),
                        const SizedBox(height: 10),
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
                              onPressed: onTapAcceptUser,
                              icon: const Icon(Icons.check_circle),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 400.ms)
                          .slideY(begin: 0.2, duration: 400.ms),
                      const SizedBox(width: 20),
                      Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.1),
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: onTapDeleteUser,
                              icon: const Icon(Icons.cancel),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 700.ms, duration: 400.ms)
                          .slideY(begin: 0.2, duration: 400.ms),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Iconsax.calendar,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              HelperFunctions().formatFirestoreTimestamp(
                                userModel.createdAt,
                              ),
                              style: const TextStyle(
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
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Iconsax.home,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Chambre: ${userModel.roomNumber}', // Room -> Chambre
                              style: const TextStyle(
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
