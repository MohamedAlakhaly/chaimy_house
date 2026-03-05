import 'package:chimay_house/core/functions/input_validation.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/global/custom_normal_button.dart';
import 'package:chimay_house/global/custom_text_form_field_widget.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/modules/add_reminder/controller/add_reminder_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/global/custom_appbar.dart';
import 'package:chimay_house/global/custom_button_with_shadow.dart';

class AddReminderView extends StatelessWidget {
  const AddReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddRemindersControllerImp());
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'addReminderTitle'.tr),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Increased padding
          child: GetBuilder<AddRemindersControllerImp>(
            builder: (myController) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                          'addReminderContent'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[700],
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 24),

                    // Appointment Type Dropdown
                    _CustomDropdownField<String>(
                          hintText: 'addReminderAppointmentType'.tr,
                          prefixIcon: Iconsax.category,
                          value: myController.selectedType,
                          items: myController.appointmentTypes.map((type) {
                            return DropdownMenuItem<String>(
                              value: type.key,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: type.color.withValues(alpha: 0.1),
                                      border: Border.all(color: type.color),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      type.icon,
                                      color: type.color,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    type.key.tr,
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white70
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              myController.setSelectedType(value),
                          isDarkMode: isDarkMode,
                        )
                        .animate()
                        .fadeIn(delay: 300.ms, duration: 600.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    CustomTextFormFieldWidget(
                          validator: (val) =>
                              inputValidation(30, 1, val!, 'date'),
                          controller: myController.dateController,
                          readOnly: true,
                          hintText: 'addReminderSelectDate'.tr,
                          prefixIcon: Iconsax.calendar,
                          onTap: () => myController.selectDate(context),
                        )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideY(begin: 0.1),

                    const SizedBox(height: 20),
                    
                    _CustomDatePickerField(
                          value: myController.formattedTime,
                          hintText: 'addReminderSelectTime'.tr,
                          prefixIcon: Iconsax.clock,
                          isDarkMode: isDarkMode,
                          onTap: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: myController.selectedTime,

                              builder: (context, child) {
                                return Theme(
                                  data: isDarkMode
                                      ? ThemeData.dark()
                                      : ThemeData.light(), // Apply theme to picker
                                  child: child!,
                                );
                              },
                            );
                            if (picked != null) {
                              myController.setSelectedTime(picked);
                            }
                          },
                        )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 600.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    // Location Input
                    _CustomTextField(
                          hintText: 'addReminderLocation'.tr,
                          prefixIcon: Iconsax.location,
                          controller: myController.locationController,
                          isDarkMode: isDarkMode,
                        )
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 20),

                    // Notes Input
                    _CustomMultiLineTextField(
                          hintText: 'addReminderNote'.tr,
                          controller: myController.noteController,
                          isDarkMode: isDarkMode,
                        )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 600.ms)
                        .slideY(begin: 0.1),
                    const SizedBox(height: 30),

                    // Add Reminder Button
                    CustomButtonWithShadow(
                          buttonText: 'addReminder'.tr,
                          onTap: myController.addReminder,
                          buttonColor: AppColors.primary,
                          isCustomChild: myController.isLoading,
                          customChild: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 600.ms)
                        .slideY(begin: 0.1),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Reusable Custom Text Form Field Widget
class _CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isDarkMode;
  final ValueChanged<String>? onChanged;

  const _CustomTextField({
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.isDarkMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}

// Reusable Custom Multi-line Text Form Field Widget
class _CustomMultiLineTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isDarkMode;
  final ValueChanged<String>? onChanged;

  const _CustomMultiLineTextField({
    required this.hintText,
    required this.controller,
    required this.isDarkMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      minLines: 3,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
        ),
        filled: true,
        fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}

// Custom Date/Time Picker Field Widget (reused and adapted)
class _CustomDatePickerField extends StatelessWidget {
  final String value; // أضفنا هذا بدلاً من الـ controller
  final String hintText;
  final IconData prefixIcon;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _CustomDatePickerField({
    required this.value, // القيمة النصية المطلوبة
    required this.hintText,
    required this.prefixIcon,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          // الـ key هنا ضروري جداً لكي يشعر الفورم بتغير الوقت ويحدث النص
          key: ValueKey(value),
          initialValue: value,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
            ),
            filled: true,
            fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool isDarkMode;

  const _CustomDropdownField({
    required this.hintText,
    required this.prefixIcon,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ), // Adjusted vertical padding
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.1 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Iconsax.arrow_down_1,
            color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
          ),
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
          dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
          onChanged: onChanged,
          items: items,
          hint: Row(
            children: [
              Icon(
                prefixIcon,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
              ),
              const SizedBox(width: 12),
              Text(
                hintText,
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
