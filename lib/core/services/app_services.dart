import 'dart:developer';
import 'dart:io';
import 'package:chimay_house/global/custom_loading_circular.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/modules/show_all_reminders/view/show_all_reminders_view.dart';
import 'package:chimay_house/modules/navigation_menu/modules/home/modules/reminders/view/reminders_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class AppServices {
  late SharedPreferences sharedPreferences;

  Future<AppServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  String getUserLanguage() {
    return sharedPreferences.getString('langCode') ?? 'en';
  }
}

Future initialService() async {
  await Get.putAsync(() => AppServices().init());
  // 2. تهيئة خدمة الإشعارات (المناطق الزمنية والإعدادات)
  await NotificationService.init();

  // 3. طلب الصلاحيات من المستخدم (تظهر الرسالة المنبثقة للأندرويد 13+ و iOS)
  await NotificationService.requestPermissions();

  print("Services Initialized ✅");
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    tz_data.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation('Europe/Brussels'));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: (response) {
        String? reminderId = response.payload;

        if (reminderId != null) {
          // مثلا فتح صفحة التذكير في التطبيق
          Get.to(() => ShowAllRemindersView());
        }
      },
    );

    // --- خطوة حاسمة: تعريف قنوات الإشعارات لنظام أندرويد ---
    if (Platform.isAndroid) {
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'reminder_v1', // نفس المعرف المستخدم في الجدولة
        'Reminders',
        description: 'Notifications for appointments',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      );

      await androidImplementation?.createNotificationChannel(channel);
    }
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required String payload,
  }) async {
    final tzDate = tz.TZDateTime.from(scheduledDate, tz.local);

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tzDate,
      payload: payload,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_v1',
          'Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );

    print("🔥 تمت جدولة الإشعار عند: $tzDate");
  }

  static Future<void> showInstantNotification() async {
    await _notificationsPlugin.show(
      id: 0,
      title: "اختبار فوري 🚀",
      body: "إذا رأيت هذا، فالمكتبة تعمل بشكل سليم",
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminder_v1',
          'Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
    print("تم إلغاء الإشعار ذو المعرف: $id");
  }

  static Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidImplementation = _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      // طلب إذن الإشعارات (لأندرويد 13 فما فوق)
      await androidImplementation?.requestNotificationsPermission();
      // طلب إذن المنبه الدقيق (لأندرويد 14 فما فوق)
      await androidImplementation?.requestExactAlarmsPermission();
    } else if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }
}

class AdminService {
  static Future<void> deleteUser(String uid) async {
    try {
      Get.dialog(
        const Center(child: CustomLoadingCircular()),
        barrierDismissible: false,
      );

      final functions = FirebaseFunctions.instanceFor(region: 'us-central1');
      final callable = functions.httpsCallable('deleteUserByAdmin');

      final result = await callable.call(<String, dynamic>{'uid': uid});

      if (Get.isDialogOpen!) {
        Get.back();
      }

      if (result.data['status'] == 'success') {
        Get.snackbar(
          'Succès',
          'L\'utilisateur et ses données ont été supprimés définitivement.', // الرسالة
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      }
    } on FirebaseFunctionsException catch (e) {
      if (Get.isDialogOpen!) Get.back();

      log('Erreur Cloud Functions: ${e.code} - ${e.message}');

      Get.snackbar(
        'Erreur de suppression',
        'Échec de l\'opération: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    } catch (e) {
      if (Get.isDialogOpen!) Get.back();

      log('Erreur inattendue: $e');

      Get.snackbar(
        'Erreur',
        'Une erreur inattendue est survenue lors de la suppression.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        margin: const EdgeInsets.all(15),
      );
    }
  }
}
