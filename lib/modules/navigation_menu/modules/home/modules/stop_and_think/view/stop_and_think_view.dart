import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/models/data/stop_and_think_data.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/stop_and_think/controller/stop_and_think_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class StopAndThinkView extends StatelessWidget {
  const StopAndThinkView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    StopAndThinkControllerImp controller = Get.put(StopAndThinkControllerImp());
    AppServices services = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: GetBuilder<StopAndThinkControllerImp>(
          builder: (myController) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: stopAndThinkData[controller.currentPage].color!
                              .withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: LinearPercentIndicator(
                      backgroundColor: isDarkMode
                          ? Colors.grey.shade700
                          : Colors.grey.shade200,
                      lineHeight: 10,
                      barRadius: const Radius.circular(12),
                      percent: controller.currentPercent,
                      animation: true,
                      animateToInitialPercent: true,
                      animateFromLastPercent: true,
                      progressColor:
                          stopAndThinkData[controller.currentPage].color,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            stopAndThinkData[controller.currentPage].color!
                                .withValues(alpha: 0.2),
                            stopAndThinkData[controller.currentPage].color!
                                .withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color:
                              stopAndThinkData[controller.currentPage].color!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: stopAndThinkData[controller.currentPage]
                                .color!
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        stopAndThinkData[controller.currentPage].iconData,
                        color: stopAndThinkData[controller.currentPage].color,
                        size: 24,
                      ),
                    )
                    .animate()
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      duration: 400.ms,
                      curve: Curves.easeOutBack,
                    )
                    .then()
                    .shimmer(
                      duration: 2000.ms,
                      color: stopAndThinkData[controller.currentPage].color!
                          .withValues(alpha: 0.3),
                    ),
              ],
            );
          },
        ),
        leading:
            Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey.shade300,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  services.getUserLanguage() == 'ar' ||
                          services.getUserLanguage() == 'ps'
                      ? Iconsax.arrow_right_3
                      : Iconsax.arrow_left_2,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                onPressed: () => Get.back(),
              ),
            ).animate().scale(
              begin: const Offset(0.8, 0.8),
              duration: 400.ms,
              curve: Curves.easeOutBack,
            ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: (val) {
                controller.currentPage = val;
                controller.addPercent();
              },
              itemCount: stopAndThinkData.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: stopAndThinkData[index].color!
                                      .withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: stopAndThinkData[index].color!
                                      .withValues(alpha: 0.3),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: InstaImageViewer(
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    24,
                                  ),
                                  child: Image.asset(
                                    stopAndThinkData[index].imagePath,
                                    height: 400,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                          .then()
                          .shimmer(
                            duration: 2000.ms,
                            color: stopAndThinkData[index].color!.withValues(
                              alpha: 0.2,
                            ),
                          ),

                      const SizedBox(height: 30),

                      Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800.withValues(alpha: 0.5)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: stopAndThinkData[index].color!
                                    .withValues(alpha: 0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            stopAndThinkData[index].color!
                                                .withValues(alpha: 0.2),
                                            stopAndThinkData[index].color!
                                                .withValues(alpha: 0.1),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        stopAndThinkData[index].iconData,
                                        color: stopAndThinkData[index].color,
                                        size: 32,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 300.ms, duration: 500.ms)
                                    .scale(
                                      begin: const Offset(0.5, 0.5),
                                      curve: Curves.easeOutBack,
                                    ),

                                const SizedBox(height: 20),

                                Text(
                                      textAlign: TextAlign.center,
                                      stopAndThinkData[index].title.tr,
                                      style: TextStyle(
                                        fontSize: AppFontsSize.largeFontSize,
                                        fontWeight: FontWeight.w800,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black87,
                                        height: 1.3,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 400.ms, duration: 600.ms)
                                    .slideY(
                                      begin: 0.3,
                                      duration: 600.ms,
                                      curve: Curves.easeOut,
                                    ),

                                const SizedBox(height: 16),

                                Container(
                                      width: 60,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            stopAndThinkData[index].color!
                                                .withValues(alpha: 0.3),
                                            stopAndThinkData[index].color!,
                                            stopAndThinkData[index].color!
                                                .withValues(alpha: 0.3),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 500.ms)
                                    .scaleX(begin: 0, duration: 400.ms),

                                const SizedBox(height: 16),

                                Text(
                                      textAlign: TextAlign.center,
                                      stopAndThinkData[index].description.tr,
                                      style: AppTextStyle.contentStyle.copyWith(
                                        color: isDarkMode
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade700,
                                        height: 1.6,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(delay: 600.ms, duration: 600.ms)
                                    .slideY(
                                      begin: 0.3,
                                      duration: 600.ms,
                                      curve: Curves.easeOut,
                                    ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 600.ms)
                          .slideY(
                            begin: 0.2,
                            duration: 600.ms,
                            curve: Curves.easeOut,
                          ),

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ),

          GetBuilder<StopAndThinkControllerImp>(
            builder: (myController) {
              return GestureDetector(
                onTap: () => controller.jumpToNextSlide(),
                child:
                    Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                stopAndThinkData[controller.currentPage].color!,
                                stopAndThinkData[controller.currentPage].color!
                                    .withValues(alpha: 0.8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: stopAndThinkData[controller.currentPage]
                                    .color!
                                    .withValues(alpha: 0.4),
                                offset: const Offset(0, 8),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 28,
                          ),
                        )
                        .animate(onPlay: (controller) => controller.repeat())
                        .scaleXY(
                          begin: 1.0,
                          end: 1.1,
                          duration: 1000.ms,
                          curve: Curves.easeInOut,
                        )
                        .then()
                        .scaleXY(
                          begin: 1.1,
                          end: 1.0,
                          duration: 1000.ms,
                          curve: Curves.easeInOut,
                        ),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
