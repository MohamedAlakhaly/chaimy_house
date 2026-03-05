import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ILAHomePage extends StatelessWidget {
  const ILAHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = HelperFunctions.isDarkMode(context);
    const Color mainColor = Colors.deepPurple;

    return Scaffold(
      appBar: CustomAppBar(title: 'ila_home_appbar_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= Welcome =================
            BuildModernCard(
              icon: Icons.home,
              iconColor: mainColor,
              title: 'welcome_title'.tr,
              items: [
                'welcome_item_1'.tr,
                'welcome_item_2'.tr,
              ],
              footerText: 'welcome_footer'.tr,
              borderColor: mainColor,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            // ================= Services =================
            BuildModernCard(
              icon: Icons.room_preferences,
              iconColor: Colors.teal,
              title: 'services_title'.tr,
              items: [
                'services_item_1'.tr,
                'services_item_2'.tr,
                'services_item_3'.tr,
                'services_item_4'.tr,
                'services_item_5'.tr,
                'services_item_6'.tr,
                'services_item_7'.tr,
              ],
              footerText: 'services_footer'.tr,
              borderColor: Colors.teal,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            // ================= Rules =================
            BuildModernCard(
              icon: Icons.rule,
              iconColor: Colors.orange,
              title: 'rules_title'.tr,
              items: [
                'rules_item_1'.tr,
                'rules_item_2'.tr,
                'rules_item_3'.tr,
                'rules_item_4'.tr,
                'rules_item_5'.tr,
                'rules_item_6'.tr,
                'rules_item_7'.tr,
                'rules_item_8'.tr,
                'rules_item_9'.tr,
              ],
              footerText: 'rules_footer'.tr,
              borderColor: Colors.orange,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            // ================= Open Structure =================
            BuildModernCard(
              icon: Icons.meeting_room_outlined,
              iconColor: Colors.indigo,
              title: 'open_structure_title'.tr,
              items: [
                'open_structure_item_1'.tr,
                'open_structure_item_2'.tr,
                'open_structure_item_3'.tr,
              ],
              footerText: 'open_structure_footer'.tr,
              borderColor: Colors.indigo,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            // ================= Questions =================
            BuildModernCard(
              icon: Icons.help_outline,
              iconColor: Colors.deepOrange,
              title: 'questions_title'.tr,
              items: [
                'questions_item_1'.tr,
              ],
              footerText: 'questions_footer'.tr,
              borderColor: Colors.deepOrange,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            // ================= Support Team =================
            BuildModernCard(
              icon: Icons.people_alt,
              iconColor: Colors.purple,
              title: 'support_team_title'.tr,
              items: [
                'support_team_item_1'.tr,
                'support_team_item_2'.tr,
                'support_team_item_3'.tr,
              ],
              footerText: 'support_team_footer'.tr,
              borderColor: Colors.purple,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 16),

            // ================= Contact =================
            BuildModernCard(
              icon: Icons.contact_mail,
              iconColor: Colors.green,
              title: 'contact_title'.tr,
              items: [
                'contact_item_1'.tr,
                'contact_item_2'.tr,
                'contact_item_3'.tr,
                'contact_item_4'.tr,
              ],
              footerText: 'contact_footer'.tr,
              borderColor: Colors.green,
              isDarkMode: isDarkMode,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:chimay_house/core/constant/app_colors.dart';
// import 'package:chimay_house/core/constant/app_images.dart';
// import 'package:chimay_house/core/constant/app_text_style.dart';
// import 'package:chimay_house/core/functions/helper_functions.dart';
// import 'package:chimay_house/core/services/app_services.dart';
// import 'package:chimay_house/global/custom_loading_circular.dart';
// import 'package:chimay_house/global/custom_normal_button.dart';
// import 'package:chimay_house/global/custom_text_form_field_widget.dart';
// import 'package:chimay_house/models/static/auth/user_model.module.dart';
// import 'package:chimay_house/modules/admin/modules/account_activation/view/account_activation_view.dart';
// import 'package:chimay_house/modules/admin/modules/user_management/controller/user_management_controller.getx.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:lottie/lottie.dart';
// import 'package:quickalert/quickalert.dart';

// class UserManagementView extends GetView<UserManagementControllerImp> {
//   const UserManagementView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => UserManagementControllerImp(), fenix: true);
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: ListView(
//         children: [
//           SizedBox(height: 40),
//           Text(
//             'Manage Users',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           ).animate()
//               .fadeIn(delay: 600.ms, duration: 600.ms)
//               .slideY(
//                 begin: 0.2,
//                 delay: 600.ms,
//                 duration: 600.ms,
//                 curve: Curves.easeOut,
//               ),
//           SizedBox(height: 20),
//           Container(
//                 padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color(0xFF1565C0),
//                       Color(0xFF0D47A1),
//                     ],
//                   ),
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(28),
//                     bottomRight: Radius.circular(28),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF1565C0).withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: const Offset(0, 8),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () => Get.back(),
//                           borderRadius: BorderRadius.circular(12),
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.arrow_back_ios_new,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 'User Management',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Manage and monitor all users',
//                                 style: TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.white.withOpacity(0.7),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                           child: const Icon(
//                             Iconsax.people,
//                             color: Colors.white,
//                             size: 24,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     // User count badge
//                     StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('users')
//                           .where('role', isEqualTo: 'user')
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         int count = snapshot.data?.docs.length ?? 0;
//                         return Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Container(
//                                 width: 8,
//                                 height: 8,
//                                 decoration: const BoxDecoration(
//                                   color: Colors.greenAccent,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Text(
//                                 '$count Total Users',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               )
//                   .animate()
//                   .fadeIn(duration: 500.ms)
//                   .slideY(begin: -0.1, duration: 500.ms, curve: Curves.easeOut),

//               const SizedBox(height: 16),
//           StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('users')
//                 .where('role', isEqualTo: 'user')
//                 .orderBy('roomNumber')
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 log(snapshot.error.toString());
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(width: double.infinity, height: 100),
//                     SvgPicture.asset(AppImages.errorGetData, height: 250),
//                     const SizedBox(height: 20),
//                     Text('error', style: AppTextStyle.titleStyle),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Error get users',
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
//                       'There is no new users',
//                       textAlign: TextAlign.center,
//                       style: AppTextStyle.contentStyle,
//                     ),
//                   ],
//                 ).animate().fadeIn(delay: 600.ms, duration: 600.ms);
//               }

//               return ListView.separated(
//                 itemCount: snapshot.data!.docs.length,
//                 shrinkWrap: true,
//                 physics: BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final data = snapshot.data!.docs[index];
//                   UserModel userModel = UserModel.fromMap(data.data(), data.id);

//                   return CustomManageUserDate(
//                     userModel: userModel,
//                     onTapDeleteUser: () {
//                       QuickAlert.show(
//                         context: context,
//                         type: QuickAlertType.error,
//                         title: 'Confirm deletion',
//                         text:
//                             'Are you sure you want to permanently delete this user?',
//                         showConfirmBtn: true,
//                         showCancelBtn: true,
//                         confirmBtnText: 'Delete',
//                         cancelBtnText: 'Cancle',
//                         confirmBtnColor: Colors.red,
//                         onConfirmBtnTap: () {
//                           AdminService.deleteUser(userModel.id, context);
//                         },
//                         onCancelBtnTap: () {
//                           Get.back();
//                         },
//                       );
//                     },
//                     onTapAcceptUser: () {
//                       controller.usernameController.text = userModel.username;
//                       controller.roomNumber.text = userModel.roomNumber
//                           .toString();
//                       controller.isActive = userModel.isActive;
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             content: Container(
//                               padding: EdgeInsets.all(10),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SizedBox(width: 400),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Username',
//                                     controller: controller.usernameController,
//                                   ),
//                                   SizedBox(height: 20),
//                                   CustomTextFormFieldWidget(
//                                     hintText: 'Room Number',
//                                     controller: controller.roomNumber,
//                                   ),
//                                   SizedBox(height: 20),
//                                   GetBuilder<UserManagementControllerImp>(
//                                     builder: (myController) {
//                                       return CheckboxListTile(
//                                         activeColor: AppColors.primary,
//                                         tileColor: Colors.grey[850],
//                                         shape: Border.all(
//                                           color: Colors.grey.shade700,
//                                         ),
//                                         title: Text('Is Active'),
//                                         value: controller.isActive,
//                                         onChanged: (val) {
//                                           controller.isActive = val!;
//                                           controller.update();
//                                         },
//                                       );
//                                     },
//                                   ),
//                                   SizedBox(height: 40),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: CustomNormalButton(
//                                           buttonText: 'Cancle',
//                                           buttonColor: Colors.red,
//                                           onTap: () => Get.back(),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Expanded(
//                                         child: CustomNormalButton(
//                                           buttonText: 'Save',
//                                           buttonColor: AppColors.primary,
//                                           onTap: () {
//                                             controller.onSaveNewData(
//                                               userModel.id,
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(height: 10),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomManageUserDate extends StatelessWidget {
//   final UserModel userModel;
//   final void Function()? onTapAcceptUser;
//   final void Function()? onTapDeleteUser;
//   const CustomManageUserDate({
//     super.key,
//     required this.userModel,
//     this.onTapAcceptUser,
//     this.onTapDeleteUser,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode = HelperFunctions.isDarkMode(context);
//     return Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.grey[isDarkMode ? 900 : 300],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                         radius: 24,
//                         backgroundColor: userModel.isActive == true
//                             ? AppColors.primary.withValues(alpha: 0.8)
//                             : Colors.red.shade900,
//                         child: Text(userModel.username.substring(0, 2)),
//                       )
//                       .animate()
//                       .fadeIn(delay: 300.ms, duration: 400.ms)
//                       .slideY(begin: 0.2, duration: 400.ms),
//                   SizedBox(width: 20),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                                   userModel.username,
//                                   style: TextStyle(
//                                     color: isDarkMode
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: AppFontsSize.smallFontSize,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 )
//                                 .animate()
//                                 .fadeIn(delay: 400.ms, duration: 400.ms)
//                                 .slideY(begin: 0.2, duration: 400.ms),
//                             if (!userModel.isActive)
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: 40,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.withValues(alpha: 0.2),
//                                   borderRadius: BorderRadius.circular(50),
//                                   border: Border.all(color: Colors.red),
//                                 ),
//                                 child: Text(
//                                   'Inactive',
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         Text(
//                               userModel.email,
//                               style: TextStyle(
//                                 color: isDarkMode
//                                     ? Colors.grey[300]
//                                     : Colors.grey[700],
//                                 fontSize: AppFontsSize.extraSmallFontSize,
//                               ),
//                             )
//                             .animate()
//                             .fadeIn(delay: 500.ms, duration: 400.ms)
//                             .slideY(begin: 0.2, duration: 400.ms),
//                       ],
//                     ),
//                   ),

//                   Row(
//                     children: [
//                       Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.primary.withValues(alpha: 0.1),
//                               border: Border.all(color: AppColors.primary),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: IconButton(
//                               onPressed: onTapAcceptUser,
//                               icon: Icon(Iconsax.edit),
//                             ),
//                           )
//                           .animate()
//                           .fadeIn(delay: 600.ms, duration: 400.ms)
//                           .slideY(begin: 0.2, duration: 400.ms),
//                       SizedBox(width: 20),
//                       Container(
//                             decoration: BoxDecoration(
//                               color: Colors.red.withValues(alpha: 0.1),
//                               border: Border.all(color: Colors.red),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: IconButton(
//                               onPressed: onTapDeleteUser,
//                               icon: Icon(Icons.delete_outline_outlined),
//                             ),
//                           )
//                           .animate()
//                           .fadeIn(delay: 700.ms, duration: 400.ms)
//                           .slideY(begin: 0.2, duration: 400.ms),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: [
//                   Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.2),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.3),
//                             width: 1,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Iconsax.calendar,
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               HelperFunctions().formatFirestoreTimestamp(
//                                 userModel.createdAt,
//                               ),
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                       .animate()
//                       .fadeIn(delay: 600.ms, duration: 400.ms)
//                       .slideY(begin: 0.2, duration: 400.ms),
//                   Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withValues(alpha: 0.2),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.white.withValues(alpha: 0.3),
//                             width: 1,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(Iconsax.home, color: Colors.white, size: 18),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Room: ${userModel.roomNumber}',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                       .animate()
//                       .fadeIn(delay: 700.ms, duration: 400.ms)
//                       .slideY(begin: 0.2, duration: 400.ms),
//                 ],
//               ),
//             ],
//           ),
//         )
//         .animate()
//         .fadeIn(delay: 200.ms, duration: 400.ms)
//         .slideY(begin: 0.2, duration: 400.ms);
//   }
// }

