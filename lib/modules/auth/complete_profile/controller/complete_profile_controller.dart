import 'dart:developer';

import 'package:chimay_house/modules/auth/logic_view/view/logic_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CompleteProfileController extends GetxController {
  void updateRoomNumber();
}

class CompleteProfileControllerImp extends CompleteProfileController {
  late TextEditingController roomNumberController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool agreePrivate = false;

  @override
  void onInit() {
    roomNumberController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    roomNumberController.dispose();
    super.dispose();
  }

  @override
  Future<void> updateRoomNumber() async {
    if (agreePrivate == true) {
      if (formKey.currentState!.validate()) {
        try {
          isLoading = true;
          update();

          String uid = FirebaseAuth.instance.currentUser!.uid;

          
          await FirebaseFirestore.instance.collection('users').doc(uid).update({
            'roomNumber': int.parse(roomNumberController.text.trim()),
          });

          Get.snackbar('completeProfileSuccessTitle'.tr, 'completeProfileSuccessContent'.tr);

          Get.offAll(() => LogicView());
        } catch (e) {
          log(e.toString());
          Get.snackbar('completeProfileErrorTitle'.tr, 'completeProfileErrorContent'.tr);
        } finally {
          isLoading = false;
          update();
        }
      }
    } else {
      Get.snackbar('failedToAgreePrivacyTitle'.tr, 'failedToAgreePrivacyContent'.tr);
    }
  }

  
}
