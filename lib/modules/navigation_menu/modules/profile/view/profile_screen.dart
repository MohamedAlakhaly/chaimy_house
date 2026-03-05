import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/auth/user_model.module.dart';
import 'package:chimay_house/modules/auth/sign_in/view/sign_in_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/about_app/view/about_app_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/change_theme/view/change_theme_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/edit_personal_detailes/view/edit_personal_detailes_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/faq/view/faq_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/modules/manage_language/view/manage_language_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    String formatFirestoreTimestampOnlyDateWithNormalStyle(
      Timestamp timestamp,
    ) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat("dd / MM / y").format(dateTime);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity, height: 100),
                  SvgPicture.asset(AppImages.errorGetData, height: 250),
                  const SizedBox(height: 20),
                  Text(
                    'cleaningScheduleErrorGetDataTitle'.tr,
                    style: AppTextStyle.titleStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'cleaningScheduleErrorGetDataContent'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.contentStyle,
                  ),
                ],
              );
            }

            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return CustomLoadingCircular();
            }

            if (snapshot.data!.data() == null) {
              return Column(  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity, height: 100),
                  SvgPicture.asset(AppImages.errorGetData, height: 250),
                  const SizedBox(height: 20),
                  Text(
                    'cleaningScheduleErrorGetDataTitle'.tr,
                    style: AppTextStyle.titleStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'cleaningScheduleErrorGetDataContent'.tr,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.contentStyle,
                  ),
                ],);
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final userModel = UserModel.fromMap(userData, snapshot.data!.id);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(userModel: userModel)
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(
                      begin: -0.2,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 20),

                _buildSectionHeader(
                  icon: Iconsax.setting_2,
                  title: 'generalCategory'.tr,
                  isDarkMode: isDarkMode,
                ).animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 600.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Icons.person_outline,
                  title: 'PersonalDetailsTitle'.tr,
                  subtitle: 'PersonalDetailsDescription'.tr,
                  isDarkMode: isDarkMode,
                  onTap: () => Get.to(
                    () => EditPersonalDetailesView(userModel: userModel),
                  ),
                ).animate()
                    .fadeIn(duration: 700.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 700.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Iconsax.language_circle,
                  title: 'lanuageTitle'.tr,
                  subtitle: 'lanuageDescription'.tr,
                  isDarkMode: isDarkMode,
                  onTap: () => Get.to(() => ManageLanguageView()),
                ).animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Iconsax.moon,
                  title: 'themeTitle'.tr,
                  subtitle: 'themeDescription'.tr,
                  isDarkMode: isDarkMode,
                  onTap: () => Get.to(() => ChangeThemeView()),
                ).animate()
                    .fadeIn(duration:900.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 900.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Iconsax.logout,
                  title: 'signOutTitle'.tr,
                  subtitle: 'signOutDescription'.tr,
                  isDarkMode: isDarkMode,
                  isDestructive: true,
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    // Get.offAll(() => SignInView());
                  },
                ).animate()
                    .fadeIn(duration: 1000.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 1000.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 30),

                _buildSectionHeader(
                  icon: Iconsax.info_circle,
                  title: 'AboutCategory'.tr,
                  isDarkMode: isDarkMode,
                ).animate()
                    .fadeIn(duration: 1100.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 1100.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Iconsax.document_text,
                  title: 'aboutAppTitle'.tr,
                  subtitle: 'aboutAppDescription'.tr,
                  isDarkMode: isDarkMode,
                  onTap: ()=>Get.to(()=>AboutAppView()),
                ).animate()
                    .fadeIn(duration: 1200.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 1200.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Iconsax.code_circle,
                  title: 'versionTitle'.tr,
                  subtitle: 'versionDescription'.tr,
                  isDarkMode: isDarkMode,
                  showArrow: false,
                  onTap: () {},
                ).animate()
                    .fadeIn(duration: 1300.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 1300.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 12),

                _buildSettingCard(
                  icon: Iconsax.shield_tick,
                  title: 'privacyPolicyTitle'.tr,
                  subtitle: 'privacyPolicyDescription'.tr,
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ).animate()
                    .fadeIn(duration: 1400.ms)
                    .slideX(
                      begin: -0.2,
                      duration: 1400.ms,
                      curve: Curves.easeOut,
                    ),

                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget _buildProfileHeader({required UserModel userModel}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
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
                      ),
                    )
                    .animate()
                    .scale(begin: const Offset(0.8, 0.8), duration: 600.ms)
                    .fadeIn(duration: 600.ms),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userModel.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
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
                          Icon(Iconsax.calendar, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '${'joinedToApplication'.tr}: ${HelperFunctions().formatFirestoreTimestampOnlyDateWithNormalStyle(userModel.createdAt)}',
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
                          Icon(Iconsax.home, color: Colors.white, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            '${'roomLableForProfileView'.tr}: ${userModel.roomNumber}',
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
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader({
  required IconData icon,
  required String title,
  required bool isDarkMode,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSettingCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  required bool isDarkMode,
  bool showArrow = true,
  bool isDestructive = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? Colors.red.withValues(alpha: 0.1)
                      : AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? Colors.red : AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDestructive
                            ? Colors.red
                            : isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (showArrow)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
            ],
          ),
        ),
      ),
    ),
  );
}
