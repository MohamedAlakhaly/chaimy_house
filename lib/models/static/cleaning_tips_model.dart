import 'package:flutter/widgets.dart';

class CleaningTipsModel {
  final IconData icon;
  final String title;
  final String? description;
  final List<String>? subSteps;

  CleaningTipsModel({
    required this.icon,
    required this.title,
    this.description,
    this.subSteps,
  });
}
