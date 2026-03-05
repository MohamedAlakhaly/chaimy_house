import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:chimay_house/modules/auth/logic_view/controller/logic_auth_controller.getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogicView extends StatelessWidget {
  const LogicView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = HelperFunctions.isDarkMode(context);
    // Get.find<LogicAuthControllerImp>();
    Get.put(LogicAuthControllerImp());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
