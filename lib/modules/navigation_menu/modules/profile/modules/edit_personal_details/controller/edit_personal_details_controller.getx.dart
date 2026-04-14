import 'dart:io';
import 'package:chimay_house/core/constant/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart'; // المكتبة المطلوبة للقص

abstract class EditPersonalDetailsController extends GetxController {}

class EditPersonalDetailsControllerImp extends EditPersonalDetailsController {
  late TextEditingController nameController;

  File? pickedImage;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  // دالة اختيار الصورة ثم قصها مباشرة
  Future<void> pickImage() async {
    // 1. اختيار الصورة من المعرض
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // 2. فتح واجهة القص (Cropping)
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // تحديد نسبة القص كمربع
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'editProfilePicture'.tr, // عنوان الواجهة
            toolbarColor: AppColors.primary, // لون الشريط العلوي
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true, // قفل النسبة لتكون مربعاً فقط
          ),
          IOSUiSettings(
            title: 'editProfilePicture'.tr,
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      // 3. إذا قام المستخدم بالقص وحفظ الصورة
      if (croppedFile != null) {
        pickedImage = File(croppedFile.path);
        update(); // تحديث الواجهة لعرض الصورة الجديدة
      }
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

        data['imageUrl'] = imageUrl; // تصحيح الخطأ الإملائي في كلمة imageUrl
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