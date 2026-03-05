import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/modules/navigation_menu/controller/navigation_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});
  @override
  Widget build(BuildContext context) {
    NavigationControllerImp controller = Get.put(NavigationControllerImp());
    bool isDartTheme = HelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Container(
        color: isDartTheme ? AppColors.bgDark : AppColors.bgLight,
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GetBuilder<NavigationControllerImp>(
            builder: (myController) {
              return SalomonBottomBar(
                backgroundColor: AppColors.primary,
                currentIndex: controller.currentIndex,
                onTap: (val) {
                  controller.currentIndex = val;
                  controller.update();
                },
                items: [
                  /// News
                  SalomonBottomBarItem(
                    icon: const Icon(Iconsax.category),
                    activeIcon: const Icon(Iconsax.category5),
                    title: Text("navigationMenuServices".tr),
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white,
                  ),

                  /// Home
                  SalomonBottomBarItem(
                    icon: const Icon(Iconsax.calendar_tick),
                    activeIcon: const Icon(Iconsax.calendar_tick5),
                    title: Text("navigationMenuEvents".tr),
                    selectedColor: Colors.white,
                    unselectedColor:Colors.white,
                  ),

                  SalomonBottomBarItem(
                    icon: Icon(Icons.tips_and_updates_outlined),
                    activeIcon: Icon(Icons.tips_and_updates),
                    title: Text("navigationMenuGuidelines".tr),
                    selectedColor: Colors.white,
                    unselectedColor:Colors.white,
                  ),


                  /// Profile
                  SalomonBottomBarItem(
                    icon: const Icon(Icons.person_2_outlined),
                    activeIcon: const Icon(Icons.person_2),
                    title: Text("navigationMenuProfile".tr),
                    selectedColor: Colors.white,
                    unselectedColor: Colors.white,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: GetBuilder<NavigationControllerImp>(builder: (myController) {
        return controller.screens[controller.currentIndex];
      }),
    );
  }
}
