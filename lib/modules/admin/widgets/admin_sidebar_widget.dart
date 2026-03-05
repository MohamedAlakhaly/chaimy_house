import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/models/data/admin_categories_data.dart';
import 'package:chimay_house/modules/admin/widgets/controller/admin_sidebar_controller.dart';
import 'package:chimay_house/modules/auth/sign_in/view/sign_in_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quickalert/quickalert.dart';

class AdminSidebarWidget extends StatelessWidget {
  const AdminSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AdminSidebarControllerImp controller = Get.find();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Align(
            alignment: AlignmentGeometry.topLeft,
            child: Text(
              'ILA Chimay',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ).animate()
              .fadeIn(delay: 800.ms, duration: 600.ms),
          SizedBox(height: 40),
          GetBuilder<AdminSidebarControllerImp>(
            builder: (myController) {
              return ListView.separated(
                itemCount: adminCategories.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                        onTap: () {
                          controller.currentIndex = index;
                          controller.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.currentIndex == index
                                ? AppColors.primary.withValues(alpha: 0.7)
                                : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(adminCategories[index].categoriesIcon),
                              SizedBox(width: 10),
                              Text(
                                adminCategories[index].categoriesName,
                                style: TextStyle(
                                  fontWeight: controller.currentIndex == index
                                      ? FontWeight.bold
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
              );
            },
          ),

          Spacer(),
          GestureDetector(
                onTap: () {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    title: 'Confirmer la déconnexion',
                    text: 'Voulez-vous vous déconnecter de votre compte ?',
                    showConfirmBtn: true,
                    showCancelBtn: true,
                    confirmBtnText: 'Déconnexion',
                    cancelBtnText: 'Annuler',
                    confirmBtnColor: AppColors.primary,
                    onConfirmBtnTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => SignInView());
                    },
                    onCancelBtnTap: () => Get.back(),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Iconsax.logout),
                      SizedBox(width: 10),
                      Text(
                        'Déconnexion',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: 600.ms)
              .slideY(
                begin: 0.2,
                delay: 800.ms,
                duration: 600.ms,
                curve: Curves.easeOut,
              )
              .then(delay: 500.ms),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
