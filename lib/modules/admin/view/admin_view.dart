import 'package:chimay_house/core/functions/responsive.dart';
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
    bool isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      drawer: !isDesktop ? const Drawer(child: AdminSidebarWidget()) : null,
      appBar: !isDesktop
          ? AppBar(title: Text("Admin Panel".tr), centerTitle: true)
          : null,

      body: Row(
        children: [
          if (isDesktop) const Expanded(flex: 2, child: AdminSidebarWidget()),
          Expanded(
            flex: 7,
            child: GetBuilder<AdminSidebarControllerImp>(
              builder: (myController) {
                return IndexedStack(
                  index: controller.currentIndex,
                  children: const [
                    UserManagementView(),
                    CleaningScheduleManagementView(),
                    AccountActivationView(), 
                    EventManagementView(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
