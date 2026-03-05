import 'package:flutter/widgets.dart';

class StopAndThinkModel {
  final String title;
  final String description;
  final String imagePath;
  final IconData? iconData;
  final Color? color;

  StopAndThinkModel({
    required this.title,
    required this.description,
    required this.imagePath,
    this.iconData,
    this.color
  });
}
