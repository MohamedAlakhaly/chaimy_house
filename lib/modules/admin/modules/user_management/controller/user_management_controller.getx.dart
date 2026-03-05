import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

abstract class UserManagementController extends GetxController {}

class UserManagementControllerImp extends UserManagementController {
  late TextEditingController usernameController;
  late TextEditingController roomNumber;
  late bool isActive;
  RxBool isLoading = false.obs;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void onInit() {
    usernameController = TextEditingController();
    roomNumber = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    usernameController.dispose();
    roomNumber.dispose();
    super.dispose();
  }

  onSaveNewData(String id) async {
    if(globalKey.currentState!.validate()){
      try {
      isLoading.value = true;
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'roomNumber': int.parse(roomNumber.text),
        'username': usernameController.text,
        'isActive': isActive,
      });
      Get.back();
      Get.snackbar(
        'Succès',
        'Les données de l’utilisateur ont été modifiées avec succès.',
      );
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Erreur',
        'Échec de la modification des données de l’utilisateur.',
      );
    } finally {
      isLoading.value = false;
    }
    }
  }
}
