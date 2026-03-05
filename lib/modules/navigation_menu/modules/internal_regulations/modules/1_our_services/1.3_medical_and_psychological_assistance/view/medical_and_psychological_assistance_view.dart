import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/modules/navigation_menu/modules/internal_regulations/modules/1_our_services/1.1_providing_basic_services/view/providing_basic_services_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class MedicalAndPsychologicalAssistanceView extends StatelessWidget {
  const MedicalAndPsychologicalAssistanceView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'medical_psych_appbar_title'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),

              _mainSection(
                title: 'medical_psych_medical_support_title'.tr,
                icon: Icons.local_hospital_rounded,
                isDarkMode: isDarkMode,
                mainColor: Colors.blue,
                childern: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 850 : 100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.2),
                      ),
                      
                    ),
                    child: Text(
                      'medical_psych_medical_support_desc'.tr,
                      style: const TextStyle(fontSize: 15, height: 1.6),
                    ),
                  ),
                ],
              )
                  .animate()
                  .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 200.ms),

              const SizedBox(height: 20),

              _mainSection(
                isDarkMode: isDarkMode,
                icon: Icons.assignment_rounded,
                title: 'medical_psych_tla_title'.tr,
                childern: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 850 : 100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_tla_point_1'.tr,
                                style:
                                    const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_tla_point_2'.tr,
                                style:
                                    const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                mainColor: Colors.green.shade600,
              )
                  .animate()
                  .slideY(begin: 0.3, duration: 700.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 400.ms),

              const SizedBox(height: 20),

              _mainSection(
                isDarkMode: isDarkMode,
                icon: Icons.event_available_rounded,
                title: 'medical_psych_appointment_rules_title'.tr,
                childern: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 850 : 100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_appointment_rule_1'.tr,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_rounded,
                              color: Colors.orange.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_appointment_rule_2'.tr,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                mainColor: Colors.orange,
              )
                  .animate()
                  .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 600.ms),

              const SizedBox(height: 20),

              _mainSection(
                isDarkMode: isDarkMode,
                icon: Icons.emergency_rounded,
                title: 'medical_psych_emergency_title'.tr,
                childern: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 850 : 100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.phone_in_talk_rounded,
                              color: Colors.red.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_emergency_point_1'.tr,
                                style:
                                    const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notifications_active_rounded,
                              color: Colors.red.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_emergency_point_2'.tr,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                mainColor: Colors.red.shade600,
              )
                  .animate()
                  .slideY(begin: 0.3, duration: 900.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 800.ms),

              const SizedBox(height: 20),

              _mainSection(
                isDarkMode: isDarkMode,
                icon: Icons.attach_money_rounded,
                title: 'medical_psych_cost_notice_title'.tr,
                childern: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 850 : 100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.cyan.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.cyan.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'medical_psych_cost_notice_desc'.tr,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                mainColor: Colors.cyan.shade600,
              )
                  .animate()
                  .slideY(begin: 0.3, duration: 1000.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 1000.ms),

              const SizedBox(height: 20),

              _mainSection(
                isDarkMode: isDarkMode,
                icon: Icons.psychology_rounded,
                title:
                    'medical_psych_psychological_support_title'.tr,
                childern: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[isDarkMode ? 850 : 100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.purple.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.purple.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_psych_support_point_1'.tr,
                                style:
                                    const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.translate_rounded,
                              color: Colors.purple.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'medical_psych_psych_support_point_2'.tr,
                                style:
                                    const TextStyle(fontSize: 15, height: 1.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                mainColor: Colors.purple.shade600,
              )
                  .animate()
                  .slideY(begin: 0.3, duration: 1100.ms, curve: Curves.easeOut)
                  .fadeIn(delay: 1200.ms),
            ],
          ),
        ),
      ),
    );
  }

  Container _mainSection({
    required bool isDarkMode,
    required IconData icon,
    required String title,
    required List<Widget> childern,
    required Color mainColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: mainColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:0.1),
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
                  color: mainColor.withValues(alpha:0.1),
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
          ...childern,
        ],
      ),
    );
  }
}
