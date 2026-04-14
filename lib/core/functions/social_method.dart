import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SocialAuth extends GetxController {
  void signInWithGoogle(bool isLoading);
}

class SocialAuthImp extends SocialAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  @override
  Future<void> signInWithGoogle(bool isLoading) async {
    try {
      isLoading = true;
      update();

      final googleUser = await _googleSignIn.authenticate();

      try {
        final googleUser = await _googleSignIn.authenticate();

        final googleAuth = googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        Get.snackbar('socialAuthErrorTitle'.tr, 'socialAuthErrorContent'.tr);
      }

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        await _saveUserToFirestore(firebaseUser);
      }
    } catch (e) {
      log("Google Error: $e");
      Get.snackbar('socialAuthErrorTitle'.tr, 'socialAuthErrorContent'.tr);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> _saveUserToFirestore(User user) async {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'userId': user.uid,
        'username': user.displayName ?? "No Name",
        'email': user.email,
        'roomNumber': null,
        'isActive': false,
        'role': 'user',
        'createAt': Timestamp.now(),
        'provider': 'google',
        'imageUrl': user.photoURL ?? '',
      });
    } else {
      await userDoc.update({'lastLogin': Timestamp.now()});
    }
  }
}
