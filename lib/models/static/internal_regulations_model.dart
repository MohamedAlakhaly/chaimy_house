import 'package:flutter/widgets.dart';

class InternalRegulationsModel {
  final IconData icon;
  final String title;
  final Color color;
  final List<InternalRegulationsDepartments> internalRegulationsDepartments;

  InternalRegulationsModel({
    required this.icon,
    required this.title,
    required this.color,
    required this.internalRegulationsDepartments,
  });
}

class InternalRegulationsDepartments {
  final IconData departmentIcon;
  final String departmentTitle;
  final String departmentDescription;
  final Color departmentColor;
  final void Function()? onTapDepartment;

  InternalRegulationsDepartments({
    required this.departmentColor,
    required this.departmentDescription,
    required this.departmentIcon,
    required this.departmentTitle,
    this.onTapDepartment
  });
}
