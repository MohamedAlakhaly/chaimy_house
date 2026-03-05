import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/models/data/cleaning_tips_data.dart';
import 'package:chimay_house/models/static/cleaning_tips_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomCleaningTipsCard extends StatelessWidget {
  final CleaningTipsModel cleaningTipsModel;
  final int index;

  const CustomCleaningTipsCard({
    super.key,
    required this.index,
    required this.cleaningTipsModel,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: isDarkMode ? Colors.grey[900] : Colors.white, // Card background
      elevation: 6, // Card elevation for shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // More rounded corners
      ),
      shadowColor: Colors.black.withValues(
        alpha: isDarkMode ? 0.15 : 0.08,
      ), // More prominent shadow
      child: ClipRRect(
        // Clip content to card shape
        borderRadius: BorderRadius.circular(20),
        child: Theme(
          // Override default ExpansionTile theme for custom colors
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: Colors.transparent,
            
          ),
          child: ExpansionTile(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            collapsedIconColor: isDarkMode
                ? Colors.grey[400]
                : Colors.grey[700],
            iconColor: AppColors.primary,
            leading:
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: 0.15,
                    ), // Slightly more opaque background
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Icon(
                    cleaningTipsModel.icon,
                    color: AppColors.primary,
                    size: 24,
                  ), // Larger icon
                ).animate().scale(
                  begin: Offset(0.7, 0.7),
                  duration: 400.ms,
                  curve: Curves.elasticOut, // More dynamic scale animation
                ),
            title:
                Text(
                      cleaningTipsModel.title.tr,
                      style: TextStyle(
                        fontSize:
                            AppFontsSize.smallFontSize, // Larger title font
                        fontWeight: FontWeight.w700, // Bolder title
                      ),
                      maxLines: 2, // Keep maxLines for title if it's too long
                      overflow: TextOverflow.ellipsis,
                    )
                    .animate()
                    .slideX(
                      begin: -0.2,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic, // Smoother slide
                    )
                    .fadeIn(duration: 600.ms),
            children: [
              if (cleaningTipsModel.description != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child:
                      Text(
                            cleaningTipsModel.description!.tr,
                            style: TextStyle(
                              fontSize: 15, // Slightly larger content font
                              height: 1.6,
                              color: isDarkMode
                                  ? Colors.grey[300]
                                  : Colors.grey[700],
                            ),
                          )
                          .animate(delay: 100.ms)
                          .slideY(
                            // Animation for content when expanded
                            begin: 0.2,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic,
                          )
                          .fadeIn(duration: 600.ms),
                ),

              if (cleaningTipsModel.subSteps != null)
                ListView.builder(
                  itemCount: cleaningTipsModel.subSteps!.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child:
                          Text(
                                cleaningTipsModel.subSteps![index].tr,
                                style: TextStyle(
                                  fontSize: 15, // Slightly larger content font
                                  height: 1.6,
                                  color: isDarkMode
                                      ? Colors.grey[300]
                                      : Colors.grey[700],
                                ),
                              )
                              .animate(delay: 100.ms)
                              .slideY(
                                // Animation for content when expanded
                                begin: 0.2,
                                duration: 500.ms,
                                curve: Curves.easeOutCubic,
                              )
                              .fadeIn(duration: 600.ms),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CleaningTipsView extends StatelessWidget {
  const CleaningTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(title:'cleaningTipAppBarTitle'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              padding: EdgeInsets.all(25), // Increased padding
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey[900]
                    : AppColors.primary.withValues(
                        alpha: 0.08,
                      ), // Lighter background for dark, subtle primary tint for light
                borderRadius: BorderRadius.circular(25), // More rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDarkMode ? 0.25 : 0.06,
                    ), // Adjusted shadow
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ],
                border: Border.all(
                  color: isDarkMode
                      ? Colors.grey[800]!
                      : AppColors.primary.withValues(
                          alpha: 0.15,
                        ), // Subtle border
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        'cleaningTipViewTitle'.tr,
                        style: TextStyle(
                          fontSize: 26, // Larger title
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      .animate()
                      .slideY(
                        begin: -0.3,
                        duration: 600.ms,
                        curve: Curves.easeOut,
                      )
                      .fadeIn(duration: 700.ms),
                  SizedBox(height: 16), // Increased spacing
                  Text(
                        'cleaningTipViewDescription'.tr,
                        style: TextStyle(
                          fontSize: 16, // Slightly larger content font
                          height: 1.7, // Increased line height
                        ),
                      )
                      .animate(delay: 200.ms)
                      .slideY(begin: 0.3, duration: 600.ms)
                      .fadeIn(duration: 700.ms),
                ],
              ),
            ).animate().slideY(
              begin: -0.5,
              duration: 800.ms,
              curve: Curves.easeOutBack,
            ),SizedBox(height: 10),
            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cleaningTipsData.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(
                      milliseconds: 450,
                    ), // Slightly longer stagger
                    child: SlideAnimation(
                      verticalOffset: 60.0, // Larger slide offset
                      child: FadeInAnimation(
                        child: CustomCleaningTipsCard(
                          index: index,
                          cleaningTipsModel: cleaningTipsData[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  //   Widget _buildSectionHeader({
  //   required String title,
  //   required IconData icon,
  //   required bool isDarkMode,
  // }) {
  //   return Padding(
  //         padding: const EdgeInsets.symmetric(
  //           vertical: 16,
  //         ), // Increased vertical padding
  //         child: Row(
  //           children: [
  //             Icon(icon, color: AppColors.primary, size: 28), // Larger icon
  //             SizedBox(width: 16), // Increased spacing
  //             Text(
  //               title,
  //               style: TextStyle(
  //                 fontSize: 22, // Larger font size
  //                 fontWeight: FontWeight.bold,
  //                 color: isDarkMode ? Colors.white : Colors.black87,
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //       .animate()
  //       .slideY(begin: -0.2, duration: 600.ms, curve: Curves.easeOut)
  //       .fadeIn(duration: 700.ms);
  // }
}
