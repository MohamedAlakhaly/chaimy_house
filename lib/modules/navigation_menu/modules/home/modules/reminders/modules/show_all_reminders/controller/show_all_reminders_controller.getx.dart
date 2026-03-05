import 'package:chimay_house/core/services/app_services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chimay_house/models/static/reminder_model.dart';

abstract class ShowAllRemindersController extends GetxController {}

class ShowAllRemindersControllerImp extends ShowAllRemindersController {
  late Box<RemindersModel> remindersBox;

  @override
  void onInit() {
    remindersBox = Hive.box<RemindersModel>('remindersBox');
    super.onInit();
  }

  Future<void> deleteReminder(RemindersModel reminder) async {
    // إلغاء الإشعار
    await NotificationService.cancelNotification(reminder.id.hashCode);
    
    // الحذف الفعلي من Hive
    await reminder.delete(); 
    
    update(); // تحديث الواجهة
  }
}