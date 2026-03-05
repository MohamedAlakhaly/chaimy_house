import 'package:chimay_house/modules/admin/modules/account_activation/view/account_activation_view.dart';
import 'package:chimay_house/modules/admin/modules/cleaning_schedule_managment/view/cleaning_schedule_managment_view.dart';
import 'package:chimay_house/modules/admin/modules/events_management/view/event_management_view.dart';
import 'package:chimay_house/modules/admin/modules/user_management/view/user_management_view.dart';
import 'package:chimay_house/modules/admin/widgets/admin_sidebar_widget.dart';
import 'package:chimay_house/modules/admin/widgets/controller/admin_sidebar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminView extends GetView<AdminSidebarControllerImp> {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AdminSidebarControllerImp(), fenix: true);
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 2, child: AdminSidebarWidget()),
          GetBuilder<AdminSidebarControllerImp>(
            builder: (myController) {
              return Expanded(
                flex: 7,
                child: controller.currentIndex == 0
                    ? UserManagementView()
                    : controller.currentIndex == 1
                    ? CleaningScheduleManagmentView()
                    : controller.currentIndex == 2
                    ? AccountActivationView()
                    : EventManagementView(),
              );
            },
          ),
        ],
      ),
    );
  }
}
