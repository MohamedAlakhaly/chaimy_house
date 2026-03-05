import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_text_style.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/models/static/events_model.dart';
import 'package:chimay_house/modules/navigation_menu/modules/events/controller/events_controller.getx.dart';
import 'package:chimay_house/modules/navigation_menu/modules/events/modules/event_details/view/events_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    EventsControllerImp controller = Get.put(EventsControllerImp());
    return Scaffold(
      appBar: CustomAppBar(title: 'eventsAppBarTitle'.tr, showBack: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              StreamBuilder(
                stream: controller.eventsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: double.infinity, height: 100),
                        SvgPicture.asset(AppImages.errorGetData, height: 250),
                        const SizedBox(height: 20),
                        Text(
                          'cleaningScheduleErrorGetDataTitle'.tr,
                          style: AppTextStyle.titleStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'cleaningScheduleErrorGetDataContent'.tr,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.contentStyle,
                        ),
                      ],
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CustomLoadingCircular();
                  }

                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final eventsSnaphote = snapshot.data!.docs[index];
                      final eventsData = EventsModel.fromMap(
                        eventsSnaphote.data() as Map<String, dynamic>,
                        eventsSnaphote.id,
                      );
                      return CustomEventsCard(eventsModel: eventsData);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
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

class CustomEventsCard extends StatelessWidget {
  final EventsModel eventsModel;

  const CustomEventsCard({super.key, required this.eventsModel});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Get.to(
          () => EventDetailView(event: eventsModel),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (eventsModel.imageUrl != '')
              ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Hero(
                          tag: 'event_image_${eventsModel.id}',
                          child: Image.network(
                            eventsModel.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: isDarkMode
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                        : null,
                                    color: AppColors.primary,
                                  ),
                                ),
                              );
                            },
                            // يمكنك أيضاً إضافة معالج للأخطاء في حال فشل تحميل الصورة
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                            
                          ),
                        ),

                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                  ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                        eventsModel.title,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 100.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 12),

                  
                  Text(
                        eventsModel.description,
                        style: TextStyle(
                          color: Colors.grey[isDarkMode ? 400 : 600],
                          fontSize: 14,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 200.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 16),

                  // Badges Row (Time + Location)
                  Wrap(
                    runSpacing: 10,
                    children: [
                      // Time Badge
                      Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Iconsax.clock,
                                  color: Colors.grey[isDarkMode ? 400 : 600],
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  HelperFunctions().formatFirestoreTimestamp(
                                    eventsModel.eventDate,
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey[isDarkMode ? 400 : 600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 300.ms)
                          .slideX(begin: -0.2, end: 0),

                      const SizedBox(width: 8),

                      // Location Badge
                      Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Iconsax.location,
                                  color: Colors.grey[isDarkMode ? 400 : 600],
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  eventsModel.location,
                                  style: TextStyle(
                                    color: Colors.grey[isDarkMode ? 400 : 600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 350.ms)
                          .slideX(begin: -0.2, end: 0),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                        children: [
                          Text(
                            'readMoreButton'.tr,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.primary,
                            size: 16,
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: 600.ms, delay: 400.ms)
                      .slideX(begin: -0.2, end: 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
