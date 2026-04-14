import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/buttons/custom_normal_button_with_shadow.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';
import 'package:chimay_house/models/static/events_model.dart';
import 'package:chimay_house/modules/navigation_menu/modules/events/modules/event_details/controller/event_details_controller.getx.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/important_number/view/important_number_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

class EventDetailView extends StatelessWidget {
  final EventsModel event;

  const EventDetailView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    EventDetailsControllerImp controller = Get.put(EventDetailsControllerImp());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDarkMode ? Colors.grey.shade900 : Colors.blue.shade50,
              isDarkMode ? Colors.black : Colors.white,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: isDarkMode
                  ? Colors.grey.shade900
                  : AppColors.primary,
              leading:
                  Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .scale(begin: const Offset(0.8, 0.8)),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (event.imageUrl.isNotEmpty)
                      Hero(
                        tag: 'event_image_${event.id}',
                        child: Image.network(event.imageUrl, fit: BoxFit.cover),
                      )
                    else
                      Container(
                        color: isDarkMode
                            ? Colors.grey.shade800
                            : AppColors.primary,
                        child: Icon(
                          Iconsax.calendar,
                          size: 100,
                          color: isDarkMode
                              ? Colors.grey.shade600
                              : Colors.white,
                        ),
                      ),

                    // Gradient overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                          event.title,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                            height: 1.3,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 100.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 20),

                    // Date and Location Cards
                    Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey.shade900
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.blue),
                                ),
                                child: Icon(
                                  Iconsax.clock,
                                  color: Colors.blue.shade600,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'eventsDataAndTimeData'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Colors.grey[isDarkMode ? 400 : 600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      HelperFunctions().formatSafeDate(
                                        event.eventDate,
                                      ),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .slideX(begin: -0.3, end: 0),

                    SizedBox(height: 10),
                    Container(        
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey.shade900
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                              
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.green.shade600,
                                  ),
                                ),
                                child: Icon(
                                  Iconsax.location,
                                  color: Colors.green.shade600,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'eventsLocationData'.tr,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Colors.grey[isDarkMode ? 400 : 600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      event.location,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 250.ms)
                        .slideX(begin: 0.3, end: 0),

                    const SizedBox(height: 10),

                    // Description Section
                    Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey.shade900
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(
                                        alpha: 0.2,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.orange.shade600,
                                      ),
                                    ),
                                    child: Icon(
                                      Iconsax.document_text,
                                      color: Colors.orange.shade600,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'eventsAboutThisEventData'.tr,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                event.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  color: Colors.grey[isDarkMode ? 400 : 700],
                                ),
                              ),
                            ],
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 300.ms)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 30),

                    // Action Button
                    if (event.registrants.contains(
                      FirebaseAuth.instance.currentUser!.uid,
                    ))
                    // AIzaSyAkcFLe23vdpZGKAMWr10DgeYUA-aQawRc
                    // 
                    CustomButtonWithShadow(
                      buttonText: 'eventsCancelRegistrationButton'.tr,
                      buttonColor: Colors.red,
                      onTap: () {
                        controller.cancelRegistration(event.id);
                      },
                    ),

                    if (!event.registrants.contains(
                      FirebaseAuth.instance.currentUser!.uid,
                    ))
                      CustomButtonWithShadow(
                            buttonColor: AppColors.primary,
                            buttonText: 'eventsRegisterForEventButton'.tr,
                            onTap: () {
                              Get.bottomSheet(
                                backgroundColor: isDarkMode
                                    ? Colors.grey[900]
                                    : Colors.white,
                                Obx(() {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 5,
                                        padding: EdgeInsetsDirectional.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(width: double.infinity),

                                            CustomUserInfoCardForRegisterEvent(
                                              cardIcon: Iconsax.home_15,
                                              iconColor: Colors.indigo,
                                              data:
                                                  '${'roomNumber'.tr} : ${controller.userDate['roomNumber']}',
                                            ),
                                            SizedBox(height: 10),
                                            CustomUserInfoCardForRegisterEvent(
                                              cardIcon: Icons.person,
                                              iconColor: Colors.orange,
                                              data:
                                                  '${'username'.tr} : ${controller.userDate['username']}',
                                            ),
                                            SizedBox(height: 10),
                                            CustomUserInfoCardForRegisterEvent(
                                              cardIcon: Icons.email,
                                              iconColor: Colors.red,
                                              data:
                                                  '${'email'.tr} : ${controller.userDate['email']}',
                                            ),
                                            SizedBox(height: 20),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      CustomNormalButtonWithShadow(
                                                        buttonText:
                                                            'editInformationButton'.tr,
                                                        shadowColor:
                                                            Colors.red.shade900,
                                                      ),
                                                ),

                                                SizedBox(width: 10),

                                                Expanded(
                                                  child: CustomNormalButtonWithShadow(
                                                    buttonText: 'confirmEventRegistrationButton'.tr,
                                                    onTap: () {
                                                      controller
                                                          .registarInEvents(
                                                            event.id,
                                                          );
                                                    },
                                                    // : Colors.green.shade900,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              );
                            },
                          )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 400.ms)
                          .slideY(begin: 0.3, end: 0)
                          .shimmer(delay: 1000.ms, duration: 2000.ms),

                    const SizedBox(height: 10),

                    CustomButtonWithShadow(
                          buttonColor: isDarkMode
                              ? Colors.white
                              : Colors.grey.shade400,
                          textColor: Colors.black,
                          buttonText: 'eventsAddToCalenderButton'.tr,
                          onTap: () {
                            final addEvent = Event(
                              title: event.title,
                              description: event.description,
                              location: event.location,
                              startDate: event.eventDate.toDate(),
                              endDate: event.eventDate.toDate(),
                              allDay: false,
                            );
                            Add2Calendar.addEvent2Cal(addEvent);
                          },
                        )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 500.ms)
                        .slideY(begin: 0.3, end: 0)
                        .shimmer(delay: 1200.ms, duration: 2000.ms),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomUserInfoCardForRegisterEvent extends StatelessWidget {
  final Color iconColor;
  final IconData cardIcon;
  final String data;
  const CustomUserInfoCardForRegisterEvent({
    super.key,
    required this.iconColor,
    required this.cardIcon,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[isDarkMode ? 850 : 200],
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor),
            ),
            child: Icon(cardIcon, color: iconColor, size: 24),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(data, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
