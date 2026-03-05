import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class CleaningScheduleController extends GetxController {}

class CleaningScheduleControllerImp extends CleaningScheduleController {
  final Future<QuerySnapshot> cleaningSchedule = FirebaseFirestore.instance
      .collection('cleaningSchedule')
      .orderBy('room', descending: false)
      .get();

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

  @override
  void onInit() {
    super.onInit();
    getUserFromFirestore(FirebaseAuth.instance.currentUser!.uid);
  }
}

