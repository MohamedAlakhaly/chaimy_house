import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

abstract class CleaningScheduleController extends GetxController {}

class CleaningScheduleControllerImp extends CleaningScheduleController {
  final Future<QuerySnapshot> cleaningSchedule = FirebaseFirestore.instance
      .collection('cleaningSchedule')
      .orderBy('end', descending: false)
      .get();

  var schedules = <QueryDocumentSnapshot>[].obs;
  var isLoading = true.obs;
  var userDate = <String, dynamic>{}.obs;

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      await getUserFromFirestore(FirebaseAuth.instance.currentUser!.uid);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cleaningSchedule')
          .orderBy('end', descending: false)
          .get();

      List<QueryDocumentSnapshot> active = [];
      List<QueryDocumentSnapshot> expired = [];

      DateTime now = DateTime.now();

      for (var doc in querySnapshot.docs) {
        DateTime endDate = (doc['end'] as Timestamp).toDate();
        if (endDate.isBefore(now)) {
          expired.add(doc);
        } else {
          active.add(doc);
        }
      }

      schedules.value = [...active, ...expired];
    } finally {
      isLoading.value = false;
    }
  }

   Future<void> getUserFromFirestore(String uid) async {
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
    fetchData();
  }
}
