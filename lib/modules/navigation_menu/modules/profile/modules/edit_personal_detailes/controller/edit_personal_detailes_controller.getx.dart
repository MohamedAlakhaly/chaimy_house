import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

abstract class EditPersonalDetailesController extends GetxController {}

class EditPersonalDetailesControllerImp extends EditPersonalDetailesController {
  late TextEditingController nameController;

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      update();
    }
  }

  updateProfile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      isLoading = true;
      update();
      Map<String, dynamic> data = {'username': nameController.text};

      if (pickedImage != null) {
        var ref = FirebaseStorage.instance
            .ref()
            .child('users_images')
            .child('$uid.jpg');

        await ref.putFile(pickedImage!);
        String imageUrl = await ref.getDownloadURL();

        data['iamgeUrl'] = imageUrl;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(data);

      Get.back();
      Get.snackbar(
        'successEditDataMessageTitle'.tr,
        'successEditDataMessageContent'.tr,
      );
    } catch (e) {
      Get.snackbar(
        'filedEditDataMessageTitle'.tr,
        'filedEditDataMessageContent'.tr,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
