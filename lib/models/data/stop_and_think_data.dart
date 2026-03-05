import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/models/static/stop_and_think_model.dart';

import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

List<StopAndThinkModel> stopAndThinkData = [
  // 1️⃣ Your guide to maintaining the house
  StopAndThinkModel(
    title: 'StopAndThinkSlideOneTitle',
    description: 'StopAndThinkSlideOneDescription',
    imagePath: AppImages.stopAndThink1,
    iconData: Iconsax.home_2,
    color: Colors.teal,
  ),

  // 2️⃣ Cleanliness and health of your home
  StopAndThinkModel(
    title: 'StopAndThinkSlideTwoTitle',
    description: 'StopAndThinkSlideTwoDescription',
    imagePath: AppImages.stopAndThink2,
    iconData: Icons.smoke_free_outlined,
    color: Colors.lightBlue,
  ),

  // 3️⃣ Safety of your door and home
  StopAndThinkModel(
    title: 'StopAndThinkSlideThreeTitle',
    description: 'StopAndThinkSlideThreeDescription',
    imagePath: AppImages.stopAndThink3,
    iconData: Iconsax.lock,
    color: Colors.orangeAccent,
  ),

  // 4️⃣ Correct furniture arrangement is your safety
  StopAndThinkModel(
    title: 'StopAndThinkSlideForeTitle',
    description: 'StopAndThinkSlideForeDescription',
    imagePath: AppImages.stopAndThink4,
    iconData: Icons.chair,
    color: Colors.indigo,
  ),

  // 5️⃣ Maintain the original layout of the furniture
  StopAndThinkModel(
    title: 'StopAndThinkSlideFiveTitle',
    description: 'StopAndThinkSlideFiveDescription',
    imagePath: AppImages.stopAndThink5,
    iconData: Iconsax.arrange_square,
    color: Colors.deepPurple,
  ),

  // 6️⃣ Prohibited things to keep you and your home safe
  StopAndThinkModel(
    title: 'StopAndThinkSlideSixTitle',
    description: 'StopAndThinkSlideSixDescription',
    imagePath: AppImages.stopAndThink6,
    iconData: Iconsax.warning_2,
    color: Colors.redAccent,
  ),

  // 7️⃣ Your safety starts in the kitchen
  StopAndThinkModel(
    title: 'StopAndThinkSlideSevenTitle',
    description: 'StopAndThinkSlideSevenDescription',
    imagePath: AppImages.stopAndThink7,
    iconData: Icons.cookie,
    color: Colors.orange,
  ),

  // 8️⃣ Save electricity and turn off the lights
  StopAndThinkModel(
    title: 'StopAndThinkSlideEightTitle',
    description: 'StopAndThinkSlideEightDescription',
    imagePath: AppImages.stopAndThink8,
    iconData: Iconsax.lamp_charge,
    color: Colors.yellow[700],
  ),

  // 9️⃣ Save heating and don't waste heat
  StopAndThinkModel(
    title: 'StopAndThinkSlideNineTitle',
    description: 'StopAndThinkSlideNineDescription',
    imagePath: AppImages.stopAndThink9,
    iconData: Iconsax.sun_1,
    color: Colors.deepOrange,
  ),

  // 🔟 No to violence... Keep calm
  StopAndThinkModel(
    title: 'StopAndThinkSlideTenTitle',
    description: 'StopAndThinkSlideTenDescription',
    imagePath: AppImages.stopAndThink10,
    iconData: Iconsax.heart,
    color: Colors.pinkAccent,
  ),
];
