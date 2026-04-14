
import 'dart:developer';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/models/static/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart' as tz;

class AppointmentType {
  final String key;
  final IconData icon;
  final Color color;
  AppointmentType({required this.key, required this.icon, required this.color});
}

class AddRemindersControllerImp extends GetxController {
  final List<AppointmentType> appointmentTypes = [
    AppointmentType(
      key: 'interview',
      icon: Iconsax.briefcase,
      color: Colors.blue.shade400,
    ),
    AppointmentType(
      key: 'doctor',
      icon: Iconsax.health,
      color: Colors.red.shade300,
    ),
    AppointmentType(
      key: 'hospital',
      icon: Iconsax.hospital,
      color: Colors.red.shade200,
    ),
    AppointmentType(
      key: 'legalAppointment',
      icon: Iconsax.document_text,
      color: Colors.deepOrange.shade400,
    ),
    AppointmentType(
      key: 'languageClass',
      icon: Iconsax.book,
      color: Colors.indigo.shade400,
    ),
    AppointmentType(
      key: 'jobInterview',
      icon: Iconsax.user_octagon,
      color: Colors.teal.shade400,
    ),
    AppointmentType(
      key: 'cvWorkshop',
      icon: Iconsax.document_upload,
      color: Colors.green.shade400,
    ),
    AppointmentType(
      key: 'socialServices',
      icon: Iconsax.people,
      color: Colors.pink.shade300,
    ),
    AppointmentType(
      key: 'educationOffice',
      icon: Iconsax.building_4,
      color: Colors.purple.shade400,
    ),
    AppointmentType(
      key: 'bankAppointment',
      icon: Iconsax.bank,
      color: Colors.amber.shade700,
    ),
    AppointmentType(
      key: 'drivingLicense',
      icon: Iconsax.car,
      color: Colors.cyan.shade600,
    ),
    AppointmentType(
      key: 'asylumOffice',
      icon: Iconsax.security_user,
      color: Colors.deepPurple.shade300,
    ),
    AppointmentType(
      key: 'registrationAppointment',
      icon: Iconsax.receipt_1,
      color: Colors.lightBlue.shade400,
    ),
    AppointmentType(
      key: 'psychologicalSupport',
      icon: Iconsax.heart_add,
      color: Colors.deepOrange.shade200,
    ),
    AppointmentType(
      key: 'garbage',
      icon: Icons.delete_outline_outlined,
      color: Colors.red.shade400,
    ),
  ];

  late TextEditingController locationController;
  late TextEditingController noteController;
  late TextEditingController dateController;

  String? selectedType;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  AppServices services = Get.find();
  String? langCode;
  bool isLoading = false;

  // تعريف الصندوق (Box) الخاص بـ Hive
  late Box<RemindersModel> reminderBox;

  @override
  void onInit() {
    locationController = TextEditingController();
    noteController = TextEditingController();

    reminderBox = Hive.box<RemindersModel>('remindersBox');

    langCode =
        services.sharedPreferences.getString('langCode') ??
        Get.deviceLocale?.languageCode ??
        'en';

    dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );

    super.onInit();
  }

  // الدوال المساعدة
  String get formattedTime {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    return DateFormat('hh:mm a', langCode).format(dateTime);
  }

  void setSelectedType(String? value) {
    selectedType = value;
    update();
  }

  void setSelectedTime(TimeOfDay time) {
    selectedTime = time;
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // يفضل أن يبدأ من اليوم
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
    }
  }

  Future<void> addReminder() async {
    if (selectedType == null) {
      Get.snackbar("errorAddReminderTitle".tr, "errorAddReminderContent".tr);
      return;
    }

    try {
      isLoading = true;
      update();

      DateTime reminderDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

      final newReminder = RemindersModel(
        id: uniqueId,
        type: selectedType!,
        location: locationController.text.trim(),
        note: noteController.text.trim(),
        dateAndTime: reminderDateTime,
        createdAt: DateTime.now(),
      );

      await reminderBox.put(uniqueId, newReminder);

      await scheduleLocalNotification(uniqueId, reminderDateTime);

      Get.back();
      Get.snackbar(
        "reminderAddedSuccessTitle".tr,
        "reminderAddedSuccessContent".tr,
      );
    } catch (e) {
      log("Error adding reminder to Hive: $e");
      Get.snackbar(
        "failedToSaveReminderTitle".tr,
        "failedToSaveReminderContent".tr,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> scheduleLocalNotification(
    String id,
    DateTime scheduledDate,
  ) async {
    try {
      String translatedType = selectedType!.tr;
      String notificationTitle = "notification_title".tr.replaceAll(
        "@",
        translatedType,
      );
      String notificationBody = "notification_body".tr.replaceAll(
        "@",
        translatedType,
      );
      final appointmentTime = tz.TZDateTime.from(scheduledDate, tz.local);

      final notificationTime = appointmentTime.subtract(
        const Duration(minutes: 1),
      );

      // final now = tz.TZDateTime.now(tz.local);

      // if (notificationTime.isBefore(now)) {
      //   await NotificationService.showInstantNotification();
      //   return;
      // }

      await NotificationService.scheduleNotification(
        id: id.hashCode,
        title: notificationTitle,
        body: notificationBody,
        scheduledDate: notificationTime,
        payload: id,
      );
    } catch (e) {
      log("❌ خطأ في جدولة الإشعار: $e");
    }
  }

  @override
  void onClose() {
    locationController.dispose();
    noteController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
