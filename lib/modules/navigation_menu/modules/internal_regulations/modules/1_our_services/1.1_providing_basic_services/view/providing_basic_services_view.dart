import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ProvidingBasicServicesView extends StatelessWidget {
  const ProvidingBasicServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'basic_services_page_title'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),

              CustomSection(
                    icon: Icons.bed_rounded,
                    title: 'basic_services_accommodation_title'.tr,
                    description: 'basic_services_accommodation_desc'.tr,
                    mainColor: Colors.green,
                    isDarkMode: isDarkMode,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 200.ms),

              const SizedBox(height: 20),

              CustomSection(
                    icon: Icons.soap_rounded,
                    title: 'basic_services_hygiene_title'.tr,
                    description: 'basic_services_hygiene_desc'.tr,
                    mainColor: Colors.blue,
                    isDarkMode: isDarkMode,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 400.ms),

              const SizedBox(height: 20),

              CustomSection(
                    icon: Icons.local_laundry_service_rounded,
                    title: 'basic_services_laundry_title'.tr,
                    description: 'basic_services_laundry_desc'.tr,
                    mainColor: Colors.purple,
                    isDarkMode: isDarkMode,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 600.ms),

              const SizedBox(height: 20),

              CustomSection(
                    icon: Icons.restaurant_rounded,
                    title: 'basic_services_meals_title'.tr,
                    description: 'basic_services_meals_desc'.tr,
                    mainColor: Colors.orange,
                    isDarkMode: isDarkMode,
                  )
                  .animate()
                  .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 800.ms),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSection extends StatelessWidget {
  const CustomSection({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.mainColor,
    required this.isDarkMode,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color mainColor;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: mainColor.withValues(alpha: 0.25),width: 2,),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
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
                  color: mainColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: mainColor, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: mainColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: mainColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
