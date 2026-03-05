import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/important_number/controller/important_number.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ImportantNumberView extends GetView<ImportantNumberImp> {
  ImportantNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImportantNumberImp());
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'importantNumberAppBaTitle'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ListView.separated(
                itemCount: importantNumber.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (content, index) {
                  final importantNumberData = importantNumber[index];
                  return Obx(() {
                    return ImportantNumberCard(
                      icon: importantNumberData.icon,
                        copyIcon:controller.copiedIndex.value == index
                          ? Icons.check
                          : Icons.copy ,
                      title: importantNumberData.title,
                      phoneNumber: importantNumberData.phoneNumber,
                      color: importantNumberData.color,
                      onTapCall: () => HelperFunctions().makePhoneCall(
                        importantNumberData.phoneNumber,
                      ),
                      index: index,
                      onTapCopyNumber: () {
                        controller.copyNumber(
                          index,
                          importantNumberData.phoneNumber,
                        );
                      },
                    );
                  });
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),

              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent.withValues(
                        alpha: isDarkMode ? 0.15 : 0.08,
                      ),
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.amberAccent.withValues(
                              alpha: 0.15,
                            ), // Icon background with category color tint
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.warning,
                            color: Colors.amberAccent,
                            size: 30,
                          ), // Larger icon
                        ).animate().scale(
                          begin: Offset(0.8, 0.8),
                          duration: 400.ms,
                          curve: Curves.easeOutCubic,
                        ),
                        CustomButtonWithOpacityColor(
                          buttonText: 'showMapButton'.tr,
                          buttonColor: Colors.amberAccent,
                          onTap: () => HelperFunctions().launchUrlMethod(
                            'https://maps.app.goo.gl/KKN7pgK5a4PMWy9b8',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'importantNoteForImportantNumber'.tr,
                      style: TextStyle(fontSize: AppFontsSize.smallFontSize),
                    ),
                    SizedBox(height: 10),
                    CustomButtonWithOpacityColor(
                      buttonColor: Colors.amberAccent,
                      buttonText: '${'callButton'.tr}     1733',
                      onTap: () => HelperFunctions().makePhoneCall('1733'),
                    ),
                    SizedBox(height: 10),
                    CustomButtonWithOpacityColor(
                      buttonColor: Colors.amberAccent,
                      buttonText: '${'callButton'.tr}     060/212233',
                      onTap: () =>
                          HelperFunctions().makePhoneCall('060/212233'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ImportantNumberInformation> importantNumber = [
    ImportantNumberInformation(
      icon: Icons.fire_truck_outlined,
      title: 'medicalAid'.tr,
      phoneNumber: '112',
      color: Colors.red,
    ),
    ImportantNumberInformation(
      icon: Icons.local_police_outlined,
      title: 'police'.tr,
      phoneNumber: '101',
      color: Colors.blue,
    ),
    ImportantNumberInformation(
      icon: Icons.add,
      title: 'redCross'.tr,
      phoneNumber: '105',
      color: Colors.red.shade900,
    ),
    ImportantNumberInformation(
      icon: Icons.coronavirus_sharp,
      title: 'antiPoisonCenter'.tr,
      phoneNumber: '070/245245',
      color: Colors.deepPurpleAccent,
    ),
    ImportantNumberInformation(
      icon: BootstrapIcons.fire,
      title: 'severeBurnsCenter'.tr,
      phoneNumber: '02/2686200',
      color: Colors.orange,
    ),
    ImportantNumberInformation(
      icon: Icons.support_agent_outlined,
      title: 'suicidePrevention'.tr,
      phoneNumber: '0800/32123',
      color: Colors.indigoAccent,
    ),
    ImportantNumberInformation(
      icon: Icons.warning_amber,
      title: 'emergencyCallForGasLeak'.tr,
      phoneNumber: '0800/87087',
      color: Colors.red,
    ),
    ImportantNumberInformation(
      icon: Icons.flood_outlined,
      title: 'nonUrgentEmergencyCall'.tr,
      phoneNumber: '1722',
      color: Colors.yellow,
    ),
    ImportantNumberInformation(
      icon: Icons.family_restroom_outlined,
      title: 'publicCenterForSocialWelfare'.tr,
      phoneNumber: '060/218930',
      color: Colors.pinkAccent,
    ),
    ImportantNumberInformation(
      icon: Iconsax.home_2,
      title: 'realEstateHousingRentalAgency'.tr,
      phoneNumber: '060/213553',
      color: Colors.green,
    ),
    ImportantNumberInformation(
      icon: Icons.phone_outlined,
      title: 'mobileNumberForTheILA'.tr,
      phoneNumber: '0473/680154',
      color: Colors.cyanAccent,
    ),
    ImportantNumberInformation(
      icon: Icons.healing_sharp,
      title: 'doctorsOnDuty'.tr,
      phoneNumber: '1733',
      color: Colors.red,
    ),
  ];
}

class CustomButtonWithOpacityColor extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  final Color buttonColor;
  const CustomButtonWithOpacityColor({
    super.key,
    this.onTap,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: buttonColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: buttonColor.withValues(alpha: 0.8)),
        ),
        child: Text(buttonText, textAlign: TextAlign.center),
      ),
    );
  }
}

class ImportantNumberInformation {
  final IconData icon;
  final String title;
  final String phoneNumber;
  final Color color;
  final VoidCallback? onTap;

  ImportantNumberInformation({
    required this.icon,
    required this.title,
    required this.phoneNumber,
    required this.color,
    this.onTap,
  });
}

class ImportantNumberCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String phoneNumber;
  final Color color;
  final void Function()? onTapCall;
  final void Function()? onTapCopyNumber;
  final int index;
  final IconData copyIcon;


  const ImportantNumberCard({
    super.key,
    required this.icon,
    required this.title,
    required this.phoneNumber,
    required this.color,
    this.onTapCall,
    this.onTapCopyNumber,
    required this.index,
    required this.copyIcon
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    final int delay = index * 100;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white, // Card background
        borderRadius: BorderRadius.circular(20), // More rounded corners
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: isDarkMode ? 0.15 : 0.08),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity),
          Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 40),
              )
              .animate(delay: (delay + 250).ms)
              .scale(
                begin: Offset(0.8, 0.8),
                duration: 400.ms,
                curve: Curves.easeOutCubic,
              ),
          SizedBox(height: 16),
          Text(
                title,
                style: TextStyle(
                  fontSize: 18, // Larger title
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              )
              .animate(delay: (delay + 250).ms)
              .slideY(begin: 0.2, duration: 500.ms)
              .fadeIn(duration: 600.ms),
          SizedBox(height: 8), // Increased spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                  )
                  .animate(delay: (delay + 250).ms)
                  .slideY(begin: 0.2, duration: 500.ms, delay: 100.ms)
                  .fadeIn(duration: 600.ms),

              Row(
                children: [
                  CustomButtonWithOpacityColor(
                        buttonText: 'callButton'.tr,
                        buttonColor: color,
                        onTap: onTapCall,
                      )
                      .animate(delay: (delay + 250).ms)
                      .slideY(begin: 0.2, duration: 500.ms, delay: 100.ms)
                      .fadeIn(duration: 600.ms),
                  SizedBox(width: 10),
                  GestureDetector(
                        onTap: onTapCopyNumber,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: color.withValues(alpha: 0.8),
                            ),
                          ),
                          child: Icon(copyIcon),
                        ),
                      )
                      .animate(delay: (delay + 250).ms)
                      .slideY(begin: 0.2, duration: 500.ms, delay: 100.ms)
                      .fadeIn(duration: 600.ms),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
