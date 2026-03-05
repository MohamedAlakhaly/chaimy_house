// import 'package:cloud_firestore/cloud_firestore.dart';

// class RemindersModel {
//   final String id;
//   final String type;
//   final Timestamp dateAndTime;
//   final Timestamp createdAt;
//   final String location;
//   final String note;

//   RemindersModel({
//     required this.id,
//     required this.type,
//     required this.createdAt,
//     required this.dateAndTime,
//     required this.location,
//     required this.note,
//   });

//   factory RemindersModel.fromMap(Map<String, dynamic> map, String id) {
//     return RemindersModel(
//         id: id,
//         type: map['type'] ?? '',
//         createdAt: map['createdAt'] ?? Timestamp.now(),
//         dateAndTime: map['dateTime'] ?? Timestamp.now(),
//         location: map['location'] ?? '',
//         note: map['note'] ?? '');
//   }
// }


import 'package:hive/hive.dart';

// هذا السطر سيختفي منه الخطأ الأحمر بعد تنفيذ أمر الـ build_runner
part 'reminder_model.g.dart'; 

@HiveType(typeId: 1) // رقم فريد لهذا الموديل
class RemindersModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final DateTime dateAndTime; // تم التغيير من Timestamp إلى DateTime

  @HiveField(3)
  final DateTime createdAt; // تم التغيير من Timestamp إلى DateTime

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String note;

  RemindersModel({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.dateAndTime,
    required this.location,
    required this.note,
  });
}