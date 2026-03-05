import 'package:chimay_house/models/static/admin_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

List<AdminCategoriesModel> adminCategories = [
  AdminCategoriesModel(categoriesName: 'Gestion des utilisateurs', categoriesIcon: Icons.person_2_outlined),
  AdminCategoriesModel(categoriesName: 'Programme de nettoyage', categoriesIcon: Icons.event_note_outlined),
  AdminCategoriesModel(categoriesName: 'Approbations des membres', categoriesIcon: Icons.check_circle_outline),
  AdminCategoriesModel(categoriesName: 'Événements', categoriesIcon: Iconsax.calendar_tick),

];
