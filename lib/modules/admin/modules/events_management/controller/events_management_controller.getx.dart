import 'dart:developer';
import 'dart:typed_data';
import 'package:chimay_house/core/functions/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EventsManagementController extends GetxController {}

class EventsManagementControllerImp extends EventsManagementController {
  GlobalKey<FormState> saveGlobleKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateGlobleKey = GlobalKey<FormState>();
  Future<void> deleteOneEvent(String id) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('events').doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        Get.snackbar('Attention', 'Événement introuvable');
        return;
      }

      final data = docSnapshot.data()!;
      final String imageUrl = data['imageUrl'] ?? '';

      if (imageUrl.isNotEmpty &&
          imageUrl.contains('firebasestorage.googleapis.com')) {
        final ref = FirebaseStorage.instance.refFromURL(imageUrl);
        await ref.delete();
      }

      await docRef.delete();

      Get.back();
      Get.snackbar('Succès', 'L\'événement a été supprimé avec succès');
    } catch (e) {
      log(e.toString());
      Get.snackbar('Erreur', 'Échec de la suppression de l\'événement');
    }
  }

  // حذف جميع الفعاليات
  Future<void> deleteAllEvents() async {
    try {
      final collection = FirebaseFirestore.instance.collection('events');
      final snapshots = await collection.get();

      if (snapshots.docs.isEmpty) {
        Get.back();
        Get.snackbar('Attention', 'Il n\'y a aucun événement à supprimer.');
        return;
      }

      for (var doc in snapshots.docs) {
        final data = doc.data();
        final String imageUrl = data['imageUrl'] ?? '';

        if (imageUrl.isNotEmpty &&
            imageUrl.contains('firebasestorage.googleapis.com')) {
          try {
            final ref = FirebaseStorage.instance.refFromURL(imageUrl);
            await ref.delete();
          } catch (e) {
            log('Échec de la suppression de l\'image: $e');
          }
        }
        await doc.reference.delete();
      }

      Get.back();
      Get.snackbar(
        'Succès',
        'Tous les événements ont été supprimés avec succès.',
      );
    } catch (e) {
      log(e.toString());
      Get.snackbar('Erreur', 'Échec de la suppression de tous les événements');
    }
  }

  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null) {
      imageBytes.value = result.files.first.bytes;
    }
  }

  clearAllData() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    date1Controller.clear();
    imageBytes.value = null;
  }

  Future<void> uploadData() async {
    if (imageBytes.value == null) {
      Get.snackbar('Erreur', 'Veuillez d\'abord choisir une image');
      return;
    }

    

    if (saveGlobleKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final ref = FirebaseStorage.instance.ref(fileName);
        await ref.putData(imageBytes.value!);
        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('events').add({
          'title': titleController.text,
          'description': descriptionController.text,
          'location': locationController.text,
          'imageUrl': imageUrl,
          'createdAt': FieldValue.serverTimestamp(),
          'registrants': [],
          'eventDate': Timestamp.fromDate(date1!),
        });

        Get.back();
        Get.snackbar(
          'Terminé',
          'Les données ont été téléchargées avec succès.',
        );
        clearAllData();
      } catch (e) {
        Get.snackbar('Erreur', e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  DateTime? date1;
  late TextEditingController date1Controller;

  Future<DateTime?> selectDateTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        controller.text = HelperFunctions().formatFirestoreTimestamp(
          Timestamp.fromDate(fullDateTime),
        );

        return fullDateTime;
      }
    }
    return null;
  }

  late TextEditingController lastTilteController;
  late TextEditingController lastDescriptionController;
  late TextEditingController lastLocationController;
  late TextEditingController date2Controller;

  DateTime? date2;
  String? oldImageUrl;
  Timestamp? oldEventDate;
  RxBool isLoadingForUpdate = false.obs;

  Rx<Uint8List?> imageBytesForUpdate = Rx<Uint8List?>(null);

  Future<void> pickImageForUpdate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (result != null) {
      imageBytesForUpdate.value = result.files.first.bytes;
    }
  }

// تحديث الفعالية - النسخة النهائية الآمنة للويب
  updateEvent(String id) async {
    if (updateGlobleKey.currentState!.validate() ?? false) {
      try {
        isLoadingForUpdate.value = true;

        // 1. التعامل الآمن مع الصورة القديمة
        // نستخدم قيمة افتراضية "" بدلاً من "!" لمنع الانهيار
        String currentImageUrl = oldImageUrl ?? ""; 
        
        // 2. التعامل الآمن مع التاريخ القديم
        // نستخدم تاريخ اللحظة كخيار احتياطي إذا كان التاريخ القديم نول
        Timestamp currentEventDate = oldEventDate ?? Timestamp.now(); 

        // 3. إذا رفع المستخدم صورة جديدة
        if (imageBytesForUpdate.value != null) {
          final fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
          final ref = FirebaseStorage.instance.ref(fileName);

          // في الويب نستخدم putData مع Uint8List
          await ref.putData(imageBytesForUpdate.value!);
          currentImageUrl = await ref.getDownloadURL();
        }

        // 4. إذا اختار المستخدم تاريخاً جديداً من الـ Picker
        if (date2 != null) {
          currentEventDate = Timestamp.fromDate(date2!);
        }

        // 5. التحديث في Firestore
        await FirebaseFirestore.instance.collection('events').doc(id).update({
          'title': lastTilteController.text,
          'description': lastDescriptionController.text,
          'location': lastLocationController.text,
          'imageUrl': currentImageUrl,
          'eventDate': currentEventDate,
        });

        Get.back();
        Get.snackbar('Succès', 'L\'événement a été modifié avec succès.');
        
        // تنظيف البيانات بعد النجاح
        imageBytesForUpdate.value = null;
        date2 = null;

      } catch (e) {
        log("Detailed Update Error: $e");
        Get.snackbar('Erreur', 'Échec de la mise à jour: $e');
      } finally {
        isLoadingForUpdate.value = false;
      }
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    locationController = TextEditingController();
    date1Controller = TextEditingController();
    lastTilteController = TextEditingController();
    lastDescriptionController = TextEditingController();
    lastLocationController = TextEditingController();
    date2Controller = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    date1Controller.dispose();
    lastTilteController.dispose();
    lastDescriptionController.dispose();
    lastLocationController.dispose();
    date2Controller.dispose();
    super.dispose();
  }
}
