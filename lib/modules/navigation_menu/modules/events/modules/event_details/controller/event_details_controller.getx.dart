import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class EventDetailsController extends GetxController {}

class EventDetailsControllerImp extends EventDetailsController {
  var userDate = <String, dynamic>{}.obs;

  getUserFromFirestore(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      userDate.value = doc.data()!;
    } else {
      userDate.value = {};
    }
  }

  registarInEvents(String eventId) async {
    await FirebaseFirestore.instance.collection('events').doc(eventId).update({
      'registrants': FieldValue.arrayUnion([
        FirebaseAuth.instance.currentUser!.uid,
      ]),
    });
    Get.back();
    Get.back();
    Get.snackbar(
      'eventRegisteredMessageTitle'.tr,
      'eventRegisteredMessageDescription'.tr,
      duration: const Duration(seconds: 2),
    );
  }

  cancelRegistration(String eventId) async {
    await FirebaseFirestore.instance.collection('events').doc(eventId).update({
      'registrants': FieldValue.arrayRemove([
        FirebaseAuth.instance.currentUser!.uid,
      ]),
    });
    Get.back();
    Get.snackbar(
      'registrationCancelledMessageTitle'.tr,
      'registrationCancelledMessageDescription'.tr,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onInit() {
    getUserFromFirestore(FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }
}
