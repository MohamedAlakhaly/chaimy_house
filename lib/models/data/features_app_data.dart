import 'package:chimay_house/models/static/features_app_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

final List<FeaturesAppModel> featuresAppList = [
  FeaturesAppModel(
    icon: Icons.alarm_rounded,
    title: 'workingHoursTitle',
    description: 'workingHoursContent',
    color: Colors.blue.shade400,
  ),
  FeaturesAppModel(
    icon: Iconsax.wifi,
    title: 'internetTitle',
    description: 'internetContent',
    color: Colors.orange.shade400,
  ),
  FeaturesAppModel(
    icon: Iconsax.call,
    title: 'importantNumbersTitle',
    description: 'importantNumbersContent',
    color: Colors.green.shade400,
  ),
  FeaturesAppModel(
    icon: Icons.gavel,
    title: 'stopAndThinkTitle',
    description: 'stopAndThinkContent',
    color: Colors.deepPurple.shade400,
  ),
  FeaturesAppModel(
    icon: Icons.cleaning_services,
    title: 'cleaningTipsTitle',
    description: 'cleaningTipsContent',
    color: Colors.limeAccent.shade400,
  ),
  FeaturesAppModel(
    icon: Icons.delete_outline,
    title: 'garbageTitle',
    description: 'garbageContent',
    color: Colors.indigo.shade400,
  ),
  FeaturesAppModel(
    icon: Icons.local_laundry_service,
    title: 'laundryTitle',
    description: 'laundryContent',
    color: Colors.teal.shade400,
  ),
  FeaturesAppModel(
    icon: Iconsax.notification,
    title: 'RemaindersTitle',
    description: 'RemaindersContent',
    color: Colors.green.shade400,
  ),
  FeaturesAppModel(
    icon: Icons.event_note_outlined,
    title: 'cleaningScheduleTitle',
    description: 'cleaningScheduleContent',
    color: Colors.red.shade400,
  ),
  FeaturesAppModel(
    icon: Iconsax.location,
    title: 'googleMapTitle',
    description: 'googleMapContent',
    color: Colors.amber.shade400,
  ),

  FeaturesAppModel(
  icon: Iconsax.calendar,
  title: 'eventsTitle',
  description: 'eventsContent',
  color: Colors.redAccent.shade400,
),

FeaturesAppModel(
  icon: Iconsax.book,
  title: 'guidelinesTitle',
  description: 'guidelinesContent',
  color: Colors.deepPurple.shade400,
),

FeaturesAppModel(
  icon: Iconsax.setting_2,
  title: 'settingsTitle',
  description: 'settingsContent',
  color: Colors.grey.shade600,
),

FeaturesAppModel(
  icon: Iconsax.user,
  title: 'profileTitle',
  description: 'profileContent',
  color: Colors.blue.shade400,
),

FeaturesAppModel(
  icon: Iconsax.notification_bing,
  title: 'notificationsTitle',
  description: 'notificationsContent',
  color: Colors.orange.shade400,
),
];