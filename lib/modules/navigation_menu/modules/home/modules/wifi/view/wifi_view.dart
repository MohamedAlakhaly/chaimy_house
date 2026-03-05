import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/wifi/controller/wifi_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WifiView extends GetView<WifiControllerImp> {
  const WifiView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    Get.lazyPut(() => WifiControllerImp());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'wifiConnectionTitle'.tr,
        actions: [
          Container(
            // height: 40,
            // width: 40,
            margin: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.qr_code_2_rounded,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("SelectTheNetworkMessageTitle".tr),
                      content: Text("SelectTheNetworkMessageContent".tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                            controller.createQrCode(
                              'Motel-22',
                              controller.password,
                            );
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Motel-22',
                                        style: TextStyle(
                                          fontSize: AppFontsSize.mediumFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 220,
                                        height: 220,
                                        child: QrImageView(
                                          data: controller.wifiQR,
                                          version: QrVersions.auto,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "Motel-22",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            Get.back();
                            controller.createQrCode(
                              'motelila',
                              controller.password,
                            );
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'motelila',
                                        style: TextStyle(
                                          fontSize: AppFontsSize.mediumFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        width: 220,
                                        height: 220,
                                        child: QrImageView(
                                          data: controller.wifiQR,
                                          version: QrVersions.auto,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            "motelila",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ).animate().scale(
            begin: const Offset(0.8, 0.8),
            duration: 400.ms,
            curve: Curves.easeOutBack,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(AppImages.wifi, height: 220),
                  )
                  .animate()
                  .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                  .scale(begin: const Offset(0.8, 0.8), duration: 600.ms)
                  .then(),

              // .shimmer(duration: 2000.ms, color: AppColors.primary.withValues(alpha: 0.2)),
              const SizedBox(height: 40),

              Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.wifi, color: AppColors.primary, size: 32)
                            .animate()
                            .fadeIn(delay: 400.ms)
                            .scale(begin: const Offset(0.5, 0.5)),

                        const SizedBox(height: 12),

                        Text(
                          'wifiConnectedto'.tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.networkName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 200.ms),

              const SizedBox(height: 30),

              Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primary),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'networkPassword'.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey[850]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade500,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.password,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 2,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),

                              Obx(() {
                                return Material(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(8),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: controller.copyWifiPassword,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          child: Icon(
                                            controller.isCopy.value == true
                                                ? Icons.check_outlined
                                                : Icons.copy,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 800.ms)
                                    .scale(begin: const Offset(0.8, 0.8))
                                    .then()
                                    .animate()
                                    .scaleXY(end: 1.1, duration: 100.ms)
                                    .then()
                                    .scaleXY(end: 1.0, duration: 100.ms);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
