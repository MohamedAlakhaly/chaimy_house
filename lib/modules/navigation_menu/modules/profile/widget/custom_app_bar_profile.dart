import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppBarProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String room;
  final Function()? onTap;
  const CustomAppBarProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.room,
    this.onTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: AppColors.primary,
      child: Stack(
        children: [
          Positioned(
            bottom: 70,
            right: -70,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: -70,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 15),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          AppImages.stopAndThink1,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                Icon(Iconsax.clock),
                                SizedBox(width: 5),
                                Text(
                                  'Joining date : 2025-10-1',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppFontsSize.largeFontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: AppFontsSize.smallFontSize - 1,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Room : 27',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Icon(Iconsax.edit, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
