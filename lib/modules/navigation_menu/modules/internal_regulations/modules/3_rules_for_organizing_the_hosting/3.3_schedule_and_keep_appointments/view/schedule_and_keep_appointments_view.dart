import 'package:chimay_house/global/cards/custom_section_internal_regulations.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_modern_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ScheduleAndKeepAppointmentsView extends StatelessWidget {
  const ScheduleAndKeepAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    const Color primaryColor = Colors.cyan;
    const Color accentColor = Colors.amber;
    const Color warningColor = Color(0xFFD32F2F);
    const Color blueColor = Color(0xFF1976D2);

    return Scaffold(
      appBar: CustomAppBar(title: 'schedule_page_title'.tr),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⚖️ Prior Approval
            BuildModernCard(
              icon: Icons.gavel,
              iconColor: warningColor,
              title: 'prior_approval_title'.tr,
              borderColor: warningColor,
              isDarkMode: isDarkMode,
              items: ['prior_approval_text'.tr],
              footerText: 'prior_approval_footer'.tr,
            ).animate()
                .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // ⏰ Mandatory Attendance
            CustomSectionForInternalRegulations(
              icon: Icons.schedule,
              title: 'mandatory_attendance_title'.tr,
              description: 'mandatory_attendance_text'.tr,
              mainColor: blueColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                .fadeIn(delay: 400.ms),
            const SizedBox(height: 20),

            // 📅 Mandatory Events
            CustomSectionForInternalRegulations(
              icon: Icons.group_work,
              title: 'mandatory_events_title'.tr,
              description: 'mandatory_events_text'.tr,
              mainColor: accentColor,
              isDarkMode: isDarkMode,
            ).animate()
                .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                .fadeIn(delay: 600.ms),

            const SizedBox(height: 24),

            // 🚌 Transport Ticket Usage
            BuildModernCard(
              icon: Icons.directions_bus,
              iconColor: primaryColor,
              title: 'transport_ticket_title'.tr,
              borderColor: primaryColor,
              isDarkMode: isDarkMode,
              items: ['transport_ticket_text'.tr],
              footerText: 'transport_ticket_footer'.tr,
            ).animate()
                .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                .fadeIn(delay: 800.ms),

            const SizedBox(height: 30),

            Center(
              child: Text(
                'schedule_footer'.tr,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 13.5,
                  color: Colors.grey[isDarkMode ? 400 : 600],
                ),
                textAlign: TextAlign.center,
              ),
            ).animate()
                .slideY(begin: 0.3, duration: 1000.ms, curve: Curves.easeOut)
                .fadeIn(delay: 1000.ms),
          ],
        ),
      ),
    );
  }
}
