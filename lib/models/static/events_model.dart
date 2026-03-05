import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel {
  final String id;
  final String title;
  final String description;
  final Timestamp eventDate;
  final String location;
  final String imageUrl;
  final Timestamp createdAt;
  final List registrants;

  EventsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.eventDate,
    required this.location,
    required this.imageUrl,
    required this.createdAt,
    required this.registrants,
  });

  factory EventsModel.fromMap(Map<String, dynamic> map, String id) {
    return EventsModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      eventDate: map['eventDate'] ?? Timestamp.now(),
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      registrants: map['registrants'] ?? [],
    );
  }
}
