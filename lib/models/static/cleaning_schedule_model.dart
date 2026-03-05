import 'package:cloud_firestore/cloud_firestore.dart';

class CleaningScheduleModel {
  final String id;
  final int roomNumber;
  final Timestamp startDate;
  final Timestamp endDate;

  CleaningScheduleModel({
    required this.id,
    required this.roomNumber,
    required this.startDate,
    required this.endDate,
  });

  factory CleaningScheduleModel.fromMap(Map<String, dynamic> map, String id) {
    return CleaningScheduleModel(
      id: id,
      roomNumber: map['room'] ?? 0,
      endDate: map['end']??Timestamp.now(),
      startDate: map['start']??Timestamp.now()
    );
  }
}
