import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/garbage/controller/garbage_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class GarbageView extends StatefulWidget {
  const GarbageView({super.key});

  @override
  State<GarbageView> createState() => _JobAndTrainingViewState();
}

class _JobAndTrainingViewState extends State<GarbageView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late GarbageControllerImp controller;

  final List<Color> tabColors = [
    Colors.amber.shade900,
    Colors.blue,
    AppColors.primary,
    Colors.red,
    Colors.indigo,
  ];

  final List<Tab> tabHeaders = [
    Tab(
      child: Row(
        children: [
          Icon(Iconsax.calendar_edit5),
          SizedBox(width: 10),
          Text('garbageScheduleTab'.tr),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
          Icon(Icons.shopping_bag),
          SizedBox(width: 10),
          Text('garbageBagTypeTab'.tr),
        ],
      ),
    ),
    Tab(
      child: Row(
        children: [
          Icon(Icons.check_circle),
          SizedBox(width: 10),
          Text('garbageAllowedItemsTab'.tr),
        ],
      ),
    ),

    // Tab(
    //   child: Row(
    //     children: [
    //       Icon(Icons.cancel),
    //       SizedBox(width: 10),
    //       Text('garbageProhibitedTab'.tr),
    //     ],
    //   ),
    // ),
    Tab(
      child: Row(
        children: [
          Icon(Icons.lightbulb),
          SizedBox(width: 10),
          Text('garbageTipsTab'.tr),
        ],
      ),
    ),
  ];

  final List<String> tabTitles = [
    'garbageScheduleTab'.tr,
    'garbageBagTypeTab'.tr,
    'garbageAllowedItemsTab'.tr,
    // 'garbageProhibitedTab'.tr,
    'garbageTipsTab'.tr,
  ];

  @override
  void initState() {
    controller = Get.put(GarbageControllerImp());
    super.initState();
    _tabController = TabController(
      length: controller.garbageTabs.length,
      vsync: this,
    );
    controller.tabController = _tabController;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color getAnimatedColor(double value) {
    int from = value.floor();
    int to = value.ceil();

    if (from < 0 || to >= tabColors.length) return tabColors[0];
    double t = value - from;
    return Color.lerp(tabColors[from], tabColors[to], t)!;
  }

  String getAnimatedTitle(double value) {
    int index = value.round();
    return tabTitles[index];
  }

  @override
  Widget build(BuildContext context) {
    AppServices services = Get.find<AppServices>();
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AnimatedBuilder(
          animation: _tabController.animation!,
          builder: (context, _) {
            final value = _tabController.animation!.value;

            return AppBar(
              title: Text(getAnimatedTitle(value)),
              toolbarHeight: 75,
              leading:
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: Icon(
                        services.getUserLanguage() == 'ar' ||
                                services.getUserLanguage() == 'ps'
                            ? Iconsax.arrow_right_3
                            : Iconsax.arrow_left_2,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ).animate().scale(
                    begin: const Offset(0.8, 0.8),
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                  ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 10),
                tabAlignment: TabAlignment.center,
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                  color: getAnimatedColor(value),
                  borderRadius: BorderRadius.circular(20),
                ),
                tabs: tabHeaders,
              ),
            );
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: controller.garbageTabs,
      ),
    );
  }
}
