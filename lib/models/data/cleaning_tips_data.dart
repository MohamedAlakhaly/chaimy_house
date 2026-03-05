import 'package:chimay_house/models/static/cleaning_tips_model.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

List<CleaningTipsModel> cleaningTipsData = [
  CleaningTipsModel(
    icon: Iconsax.trash, // 🗑️ رمي القمامة
    title: 'cleaningTipOneTitle',
    description: 'cleaningTipOneDescription',
  ),
  CleaningTipsModel(
    icon: Icons.dry_cleaning, // 🧺 تنظيم الغسيل وترتيب السرير
    title: 'cleaningTipTwoTitle',
    description: 'cleaningTipTwoDescription',
  ),
  CleaningTipsModel(
    icon: Iconsax.brush, // 🧽 تنظيف الغبار
    title: 'cleaningTipThreeTitle',
    description: 'cleaningTipThreeDescription',
  ),
  CleaningTipsModel(
    icon: Iconsax.broom, // 🧹 كنس أو شفط الأرضية
    title: 'cleaningTipForeTitle',
    description: 'cleaningTipForeDescription',
  ),
  CleaningTipsModel(
    icon: Iconsax.bucket, // 🪣 غسل الأرضية
    title: 'cleaningTipFiveTitle',
    description: 'cleaningTipFiveDescription',
    subSteps: [
      'cleaningTipFiveSubDescriptionOne',
      'cleaningTipFiveSubDescriptionTwo',
      'cleaningTipFiveSubDescriptionThree',
      'cleaningTipFiveSubDescriptionFore',
      'cleaningTipFiveSubDescriptionFive',
    ],
  ),
  CleaningTipsModel(
    icon: Icons.bathtub, // 🛁 تنظيف الحمام
    title: 'cleaningTipSixTitle',
    description: 'cleaningTipSixDescription',
    subSteps: [
      'cleaningTipSixSubDescriptionOne',
      'cleaningTipSixSubDescriptionTwo',
      'cleaningTipSixSubDescriptionThree',
      'cleaningTipSixSubDescriptionFore',
      'cleaningTipSixSubDescriptionFive',
    ],
  ),
  CleaningTipsModel(
    icon: Icons.kitchen, // 🧊 تنظيف الثلاجة
    title: 'cleaningTipSevenTitle',
    description: 'cleaningTipSevenDescription',
  ),
  CleaningTipsModel(
    icon: Iconsax.wind, // 🌬 تهوية الغرفة
    title: 'cleaningTipEightTitle',
    description: 'cleaningTipEightDescription',
  ),
];
