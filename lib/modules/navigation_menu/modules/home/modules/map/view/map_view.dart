import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/map/controller/map_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';

class ImportantPlacesView extends StatelessWidget {
  const ImportantPlacesView({super.key});

  @override
  Widget build(BuildContext context) {
    final ImportantPlacesController controller = Get.put(
      ImportantPlacesController(),
    );
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'importantPlacesAppBarTitle'.tr,

        actions: [
          Obx(() {
            return GestureDetector(
              onTap: controller.switchMapType,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: controller.isNormalType.value
                      ? Colors.red.withValues(alpha: 0.4)
                      : AppColors.primary.withValues(alpha: 0.4),
                  border: Border.all(
                    color: controller.isNormalType.value
                        ? Colors.red
                        : AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  controller.isNormalType.value ? Icons.map : Icons.layers,
                ),
              ),
            ).animate().fadeIn(duration: 600.ms);
          }),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            if (!controller.markersLoaded.value) {
              return Center(child: CircularProgressIndicator()); // مؤقتًا
            }

            return GoogleMap(
              mapType: controller.isNormalType.value
                  ? MapType.normal
                  : MapType.hybrid,
              myLocationEnabled: true,
              initialCameraPosition: ImportantPlacesController.initialPosition,
              onMapCreated: (GoogleMapController c) {
                controller.mapController.complete(c);
              },
              markers: controller.markers,
            );
          }).animate().fadeIn(duration: 600.ms),

          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child:
                Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDarkMode
                              ? [
                                  Colors.black.withValues(alpha: 0.70),
                                  Colors.black.withValues(alpha: 0.65),
                                ]
                              : [
                                  Colors.white.withValues(alpha: 0.95),
                                  Colors.white.withValues(alpha: 0.85),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => Row(
                            children: [
                              _buildFilterButton(
                                controller,
                                "all",
                                "importantPlacesAll".tr,
                                Icons.public,
                                0,
                              ),
                              _buildFilterButton(
                                controller,
                                "shopping",
                                "importantPlacesShopping".tr,
                                Icons.shopping_bag,
                                1,
                              ),

                              _buildFilterButton(
                                controller,
                                "government",
                                "importantPlacesGoverment".tr,
                                Icons.account_balance,
                                2,
                              ),

                              _buildFilterButton(
                                controller,
                                "busStation",
                                "importantPlacesBusStation".tr,
                                Icons.bus_alert_outlined,
                                2,
                              ),

                              _buildFilterButton(
                                controller,
                                "bank",
                                "importantPlacesBank".tr,
                                Icons.euro,
                                2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .slideY(
                      begin: -0.5,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    )
                    .fadeIn(),
          ),
        ],
      ),

      floatingActionButton:
          Obx(() {
                if (controller.selectedPlace.value != null) {
                  return const SizedBox.shrink();
                }
                return FloatingActionButton.extended(
                  onPressed: controller.goToMyLocation,
                  backgroundColor: Colors.black,
                  icon: const Icon(Icons.my_location, color: Colors.white),
                  label: Text(
                    'importantPlacesMyLocationButton'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              })
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scaleXY(end: 1.05, duration: 1500.ms, curve: Curves.easeInOut)
              .then()
              .scaleXY(end: 1.0, duration: 1500.ms, curve: Curves.easeInOut),

      bottomSheet: Obx(() {
        final place = controller.selectedPlace.value;
        if (place == null) return const SizedBox.shrink();

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ).animate().fadeIn(delay: 100.ms),

              const SizedBox(height: 16),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.place,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (controller.calculateDistance(place) != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'distance_meter'.trParams({
                          'distance': controller
                              .calculateDistance(place)!
                              .toStringAsFixed(0),
                        }),
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                ],
              ).animate().slideX(begin: -0.2, duration: 400.ms).fadeIn(),

              const SizedBox(height: 16),

              Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 800 : 300],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade400,
                      ),
                    ),
                    child: Text(
                      place.description,
                      style: TextStyle(
                        fontSize: AppFontsSize.extraSmallFontSize,
                        color: isDarkMode ? Colors.grey : Colors.black,
                        height: 1.5,
                      ),
                    ),
                  )
                  .animate()
                  .slideY(begin: 0.2, duration: 500.ms, delay: 100.ms)
                  .fadeIn(),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child:
                        ElevatedButton.icon(
                          onPressed: () => controller.openNavigation(place),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.location_on, size: 20),
                          label: Text(
                            'importantPlacesOpenInMapButton'.tr,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ).animate().scale(
                          begin: const Offset(0.9, 0.9),
                          delay: 200.ms,
                          duration: 400.ms,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => controller.selectedPlace.value = null,
                      icon: Icon(Icons.close, color: Colors.grey.shade500),
                      tooltip: 'close'.tr,
                    ),
                  ).animate().scale(
                    begin: const Offset(0.9, 0.9),
                    delay: 250.ms,
                    duration: 400.ms,
                  ),
                ],
              ),
            ],
          ),
        ).animate().slideY(begin: 1.0, duration: 400.ms, curve: Curves.easeOut);
      }),
    );
  }

  Widget _buildFilterButton(
    ImportantPlacesController controller,
    String type,
    String label,
    IconData icon,
    int index,
  ) {
    final isSelected = controller.selectedCategory.value == type;

    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: FilterChip(
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ],
            ),
            selected: isSelected,
            onSelected: (_) {
              controller.selectedCategory.value = type;
              controller.selectedPlace.value = null;
            },
            backgroundColor: Colors.white,
            selectedColor: AppColors.primary,
            checkmarkColor: Colors.white,
            elevation: isSelected ? 4 : 0,
            shadowColor: Colors.blue.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
          ),
        )
        .animate()
        .slideX(
          begin: -0.3,
          duration: 400.ms,
          delay: (100 * index).ms,
          curve: Curves.easeOut,
        )
        .fadeIn(delay: (100 * index).ms);
  }
}
