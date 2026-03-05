import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class EventsController extends GetxController {}

class EventsControllerImp extends EventsController {
  final Stream<QuerySnapshot> eventsStream = FirebaseFirestore.instance
      .collection('events').orderBy('eventDate')
      .snapshots();
}
