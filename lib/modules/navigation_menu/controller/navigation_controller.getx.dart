import 'package:chimay_house/modules/navigation_menu/modules/events/view/events_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/view/home_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/profile/view/profile_screen.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/view/reminders_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/view/internal_regulations_view.dart';

import 'package:get/get.dart';

abstract class NavigationController extends GetxController {}

class NavigationControllerImp extends NavigationController {
  int currentIndex = 0;
  List screens = [
    HomeView(),
    EventsView(),
    InternalRegulationsView(),
    ProfileView(),
  ];
}
