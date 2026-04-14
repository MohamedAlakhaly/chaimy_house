import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/models/static/reminder_model.dart'; // تأكد من المسار
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class RemindersController extends GetxController {}

class RemindersControllerImp extends RemindersController {
  // الخرائط (الألوان والأيقونات) تبقى كما هي
  final Map<String, IconData> appointmentTypeIcons = {
    'interview': Iconsax.briefcase,
    'doctor': Iconsax.health,
    'hospital': Iconsax.hospital,
    'legalAppointment': Iconsax.document_text,
    'languageClass': Iconsax.book,
    'jobInterview': Iconsax.user_octagon,
    'cvWorkshop': Iconsax.document_upload,
    'socialServices': Iconsax.people,
    'educationOffice': Iconsax.building_4,
    'bankAppointment': Iconsax.bank,
    'drivingLicense': Iconsax.car,
    'asylumOffice': Iconsax.security_user,
    'registrationAppointment': Iconsax.receipt_1,
    'psychologicalSupport': Iconsax.heart_add,
    'garbage': Icons.delete_outline_outlined,
  };

  final Map<String, Color> appointmentTypeColors = {
    'interview': Colors.blue.shade400,
    'doctor': Colors.red.shade300,
    'hospital': Colors.red.shade200,
    'legalAppointment': Colors.deepOrange.shade400,
    'languageClass': Colors.indigo.shade400,
    'jobInterview': Colors.teal.shade400,
    'cvWorkshop': Colors.green.shade400,
    'socialServices': Colors.pink.shade300,
    'educationOffice': Colors.purple.shade400,
    'bankAppointment': Colors.amber.shade700,
    'drivingLicense': Colors.cyan.shade600,
    'asylumOffice': Colors.deepPurple.shade300,
    'registrationAppointment': Colors.lightBlue.shade400,
    'psychologicalSupport': Colors.deepOrange.shade200,
    'garbage': Colors.red.shade400,
  };

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  late Box<RemindersModel> remindersBox;
  AppServices services = Get.find();
  late String langCode;

  @override
  void onInit() {
    remindersBox = Hive.box<RemindersModel>('remindersBox');

    String currentLang =
        services.sharedPreferences.getString('langCode') ??
        Get.deviceLocale?.languageCode ??
        'en';

    List<String> calendarSafeLocales = [
      'en',
      'ar',
      'fr',
      'tr',
      'es',
      'nl',
      'uk',
    ];

    if (calendarSafeLocales.contains(currentLang)) {
      langCode = currentLang;
    } else {
      langCode = 'en';
    }
    super.onInit();
  }

  void deleteReminder(RemindersModel reminder) async {
    await NotificationService.cancelNotification(reminder.id.hashCode);
    await reminder.delete(); // حذف من Hive
    update();
  }
}
