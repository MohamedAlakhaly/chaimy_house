import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final int? roomNumber;
  final bool isActive;
  final String email;
  final Timestamp createdAt;
  final String role;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.imageUrl,
    required this.email,
    required this.username,
    required this.roomNumber,
    required this.isActive,
    required this.createdAt,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      roomNumber: map['roomNumber'] ?? 0,
      isActive: map['isActive'] ?? false,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      role: map['role'] ?? 'user',
      imageUrl: map['imageUrl']??''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'roomNumber': roomNumber,
      'isActive': isActive,
    };
  }
}
