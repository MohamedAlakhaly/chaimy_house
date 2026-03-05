// import 'dart:developer';
// import 'package:chimay_house/core/functions/helper_functions.dart';
// import 'package:chimay_house/core/services/app_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:intl/intl.dart';
// import 'package:timezone/timezone.dart' as tz;

// abstract class AddRemindersController extends GetxController {}

// class AddRemindersControllerImp extends AddRemindersController {
//   final List<AppointmentType> appointmentTypes = [
//     AppointmentType(
//       key: 'interview',
//       icon: Iconsax.briefcase,
//       color: Colors.blue.shade400,
//     ),
//     AppointmentType(
//       key: 'doctor',
//       icon: Iconsax.health,
//       color: Colors.red.shade300,
//     ),
//     AppointmentType(
//       key: 'hospital',
//       icon: Iconsax.hospital,
//       color: Colors.red.shade200,
//     ),
//     AppointmentType(
//       key: 'legalAppointment',
//       icon: Iconsax.document_text,
//       color: Colors.deepOrange.shade400,
//     ),
//     AppointmentType(
//       key: 'languageClass',
//       icon: Iconsax.book,
//       color: Colors.indigo.shade400,
//     ),
//     AppointmentType(
//       key: 'jobInterview',
//       icon: Iconsax.user_octagon,
//       color: Colors.teal.shade400,
//     ),
//     AppointmentType(
//       key: 'cvWorkshop',
//       icon: Iconsax.document_upload,
//       color: Colors.green.shade400,
//     ),
//     AppointmentType(
//       key: 'socialServices',
//       icon: Iconsax.people,
//       color: Colors.pink.shade300,
//     ),
//     AppointmentType(
//       key: 'educationOffice',
//       icon: Iconsax.building_4,
//       color: Colors.purple.shade400,
//     ),
//     AppointmentType(
//       key: 'bankAppointment',
//       icon: Iconsax.bank,
//       color: Colors.amber.shade700,
//     ),
//     AppointmentType(
//       key: 'drivingLicense',
//       icon: Iconsax.car,
//       color: Colors.cyan.shade600,
//     ),
//     AppointmentType(
//       key: 'asylumOffice',
//       icon: Iconsax.security_user,
//       color: Colors.deepPurple.shade300,
//     ),
//     AppointmentType(
//       key: 'registrationAppointment',
//       icon: Iconsax.receipt_1,
//       color: Colors.lightBlue.shade400,
//     ),
//     AppointmentType(
//       key: 'psychologicalSupport',
//       icon: Iconsax.heart_add,
//       color: Colors.deepOrange.shade200,
//     ),
//     AppointmentType(
//       key: 'garbage',
//       icon: Icons.delete_outline_outlined,
//       color: Colors.red.shade400,
//     ),
//   ];

//   // 2. المتغيرات والتحكم
//   String get userId => FirebaseAuth.instance.currentUser?.uid ?? "";
//   late TextEditingController locationController;
//   late TextEditingController noteController;
//   late TextEditingController dateController;

//   String? selectedType;
//   TimeOfDay selectedTime = TimeOfDay.now();
//   DateTime selectedDate = DateTime.now();

//   AppServices services = Get.find();
//   String? langCode;
//   bool isLoading = false;

//   @override
//   void onInit() async {
//     locationController = TextEditingController();
//     noteController = TextEditingController();

//     langCode =
//         services.sharedPreferences.getString('langCode') ??
//         Get.deviceLocale?.languageCode ??
//         'en';

//     // تهيئة التاريخ الافتراضي في الحقل
//     dateController = TextEditingController(
//       text: HelperFunctions().formatFirestoreTimestampOnlyDate(Timestamp.now()),
//     );
//     // في الكنترولر، جرب هذا الكود البسيط جداً للاختبار

//     super.onInit();
//   }

//   // 3. الدوال المساعدة
//   String get formattedTime {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       selectedTime.hour,
//       selectedTime.minute,
//     );
//     return DateFormat('hh:mm a', langCode).format(dateTime);
//   }

//   void setSelectedType(String? value) {
//     selectedType = value;
//     update();
//   }

//   void setSelectedTime(TimeOfDay time) {
//     selectedTime = time;
//     update();
//   }

//   Future<void> selectDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       selectedDate = picked;
//       dateController.text = HelperFunctions().formatFirestoreTimestampOnlyDate(
//         Timestamp.fromDate(picked),
//       );
//       update();
//     }
//   }

//   // 4. دالة الحفظ
//   Future<void> addReminder() async {
//     if (selectedType == null) {
//       Get.snackbar("errorAddReminderTitle".tr, "errorAddReminderContent".tr);
//       return;
//     }

//     try {
//       isLoading = true;
//       update();

//       DateTime reminderDateTime = DateTime(
//         selectedDate.year,
//         selectedDate.month,
//         selectedDate.day,
//         selectedTime.hour,
//         selectedTime.minute,
//       );

//       final docRef = FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .collection('reminders')
//           .doc();

//       await docRef.set({
//         'id': docRef.id,
//         'type': selectedType,
//         'location': locationController.text.trim(),
//         'note': noteController.text.trim(),
//         'dateTime': Timestamp.fromDate(reminderDateTime),
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       Get.back();
//       Get.snackbar(
//         "reminderAddedSuccessTitle".tr,
//         "reminderAddedSuccessContent".tr,
//       );

//       try {
//         // 1. احصل على وقت "الآن" من داخل مكتبة التوقيت نفسها (وليس وقت الجوال العادي)
// final now = tz.TZDateTime.now(tz.local);

// // 2. حول الموعد الذي اختاره المستخدم إلى صيغة المكتبة
// final appointmentTime = tz.TZDateTime(
//   tz.local,
//   selectedDate.year,
//   selectedDate.month,
//   selectedDate.day,
//   selectedTime.hour,
//   selectedTime.minute,
// );

// // 3. اطرح ساعتين من الموعد (وقت التنبيه)
// final notificationTime = appointmentTime.subtract(const Duration(minutes: 1));

// // 4. الجدولة (فقط إذا كان وقت التنبيه في المستقبل بالنسبة لوقت المكتبة)
// if (notificationTime.isAfter(now)) {
//   await NotificationService.scheduleNotification(
//     id: docRef.id.hashCode,
//     title: "تذكير بموعد ⏰",
//     body: "موعدك بعد ساعتين!",
//     scheduledDate: notificationTime, // نمرر الكائن الجاهز مباشرة
//   );
//   print("تمت الجدولة بنجاح باستخدام توقيت المكتبة المحلي");
// } else {
//   // إشعار فوري إذا كان الموعد بعد أقل من ساعتين
//   // await NotificationService.showInstantNotification();
// }
//       } catch (e) {
//         log("خطأ في جدولة الإشعار: $e");
//       }
//     } catch (e) {
//       Get.snackbar("errorAddReminderTitle".tr, "reminderAddError".tr);
//     } finally {
//       isLoading = false;
//       update();
//     }
//   }

//   @override
//   void onClose() {
//     locationController.dispose();
//     noteController.dispose();
//     dateController.dispose();
//     super.onClose();
//   }
// }

import 'dart:developer';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/models/static/reminder_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart' as tz;
// استيراد الموديل الذي أنشأناه

class AppointmentType {
  final String key;
  final IconData icon;
  final Color color;
  AppointmentType({required this.key, required this.icon, required this.color});
}

class AddRemindersControllerImp extends GetxController {
  // 1. القائمة الخاصة بأنواع المواعيد (كما هي)
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

  // --- دالة الحفظ المعدلة لتعمل مع Hive ---
  Future<void> addReminder() async {
    if (selectedType == null) {
      Get.snackbar("errorAddReminderTitle".tr, "errorAddReminderContent".tr);
      return;
    }

    try {
      isLoading = true;
      update();

      // 1. تحديد وقت الموعد
      DateTime reminderDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // 2. إنشاء ID فريد رقمي (HashCode) لاستخدامه في الإشعارات و Hive
      String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

      // 3. إنشاء الكائن للحفظ في Hive
      final newReminder = RemindersModel(
        id: uniqueId,
        type: selectedType!,
        location: locationController.text.trim(),
        note: noteController.text.trim(),
        dateAndTime: reminderDateTime,
        createdAt: DateTime.now(),
      );

      // 4. الحفظ الفوري في الهاتف
      await reminderBox.put(uniqueId, newReminder);

      // 5. جدولة الإشعار
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

      final now = tz.TZDateTime.now(tz.local);

      if (notificationTime.isBefore(now)) {
        await NotificationService.showInstantNotification();
        return;
      }

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
