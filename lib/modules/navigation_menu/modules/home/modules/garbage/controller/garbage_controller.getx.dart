import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/tabs/garbage_allowed_items/view/garbage_allowed_items_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/tabs/garbage_bag_type/view/garbage_bag_type_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/tabs/garbage_prohibited/view/garbage_prohibited_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/tabs/garbage_schedule/view/garbage_schedule_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/tabs/garbage_tips/view/garbage_tips_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class GarbageController extends GetxController {}

class GarbageControllerImp extends GarbageController {
  late TabController tabController;

  int selectedIndex = 0;
  List<Widget> garbageTabs = [
    GarbageScheduleView(),
    GarbageBagTypeView(),
    GarbageAllowedItemsView(),
    // GarbageProhibitedView(),
    GarbageTipsView()
  ];
}
