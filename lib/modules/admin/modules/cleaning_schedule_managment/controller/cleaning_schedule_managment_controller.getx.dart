import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CleaningScheduleManagementController extends GetxController {
  void deleteOneOfCleaningSchedule(String id);
}

class CleaningScheduleManagementControllerImp
    extends CleaningScheduleManagementController {
  @override
  deleteOneOfCleaningSchedule(String id) async {
    await FirebaseFirestore.instance
        .collection('cleaningSchedule')
        .doc(id)
        .delete();
    Get.back();
    // Success -> Succès | successfully deleted -> supprimé avec succès
    Get.snackbar(
      'Succès',
      'Ce planning de nettoyage a été supprimé avec succès',
    );
  }

  deleteAllOfCleaningSchedule() async {
    var collection = FirebaseFirestore.instance.collection('cleaningSchedule');

    var snapshots = await collection.get();

    if (snapshots.docs.isEmpty) {
      Get.back();
      // Warning -> Avertissement | There is no cleanup schedule -> Il n'y a aucun planning à supprimer
      Get.snackbar(
        'Avertissement',
        "Il n'y a aucun planning de nettoyage à supprimer.",
      );
      return;
    }

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
      Get.back();
      Get.snackbar(
        'Succès',
        'L’intégralité du planning de nettoyage a été supprimée avec succès.',
      );
    }
  }

  late TextEditingController roomController;
  late TextEditingController date1Controller;
  late TextEditingController date2Controller;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;
  DateTime? date1;
  DateTime? date2;

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
    bool isFirst,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      if (isFirst) {
        date1 = picked;
      } else {
        date2 = picked;
      }
    }
  }

  Future<void> saveData() async {
    // if (roomController.text.isEmpty || date1 == null || date2 == null) {
    //   Get.snackbar('Erreur', 'Veuillez remplir tous les champs.');
    //   return;
    // }

    if (globalKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await FirebaseFirestore.instance.collection('cleaningSchedule').add({
          'room': int.parse(roomController.text),
          'start': Timestamp.fromDate(date1!),
          'end': Timestamp.fromDate(date2!),
        });

        roomController.clear();
        date1Controller.clear();
        date2Controller.clear();
        date1 = null;
        date2 = null;
        Get.back();
        Get.snackbar(
          'Succès',
          'Le planning de nettoyage a été ajouté avec succès.',
        );
      } catch (e) {
        // Failed to add -> Échec de l'ajout
        Get.snackbar('Erreur', "Échec de l'ajout du planning de nettoyage.");
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onInit() {
    roomController = TextEditingController();
    date1Controller = TextEditingController();
    date2Controller = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    roomController.dispose();
    date1Controller.dispose();
    date2Controller.dispose();
    super.dispose();
  }
}
