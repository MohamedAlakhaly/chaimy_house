import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

abstract class AccountActivationController extends GetxController {}

class AccountActivationControllerImp extends AccountActivationController{

    acceptUser(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'isActive':true,
    });
  }
}