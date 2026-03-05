
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignUpController extends GetxController {
  void showPassword();
  void goToSignIn();
  void signUp();
}

class SignUpControllerImp extends SignUpController {
  bool obscureText = true;
  bool agreePrivate = false;
  IconData visibilityIcon = Icons.visibility_off_outlined;
  bool isLoading = false;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late TextEditingController roomNumberController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  showPassword() {
    obscureText = !obscureText;
    obscureText == true
        ? visibilityIcon = Icons.visibility_off_outlined
        : visibilityIcon = Icons.visibility_outlined;
    update();
  }

  @override
  goToSignIn() {
    Get.toNamed(AppRoutes.signIn);
  }

  @override
  signUp() async {
    if (globalKey.currentState!.validate()) {
      if (agreePrivate == true) {
        try {
          isLoading = true;
          update();
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          FirebaseAuth.instance.currentUser!.sendEmailVerification();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({
                'userId': FirebaseAuth.instance.currentUser!.uid,
                'roomNumber': int.parse(roomNumberController.text),
                'isActive': false,
                'username': usernameController.text.trim(),
                'email': emailController.text.trim(),
                'createAt': Timestamp.now(),
                'role': 'user',
              });
          Get.offAllNamed(AppRoutes.verifyEmail);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar('weakPasswordTitle'.tr, 'weakPasswordContent'.tr);
            isLoading = false;
            update();
          } else if (e.code == 'email-already-in-use') {
            Get.snackbar(
              'emailAlreadyInUseTitle'.tr,
              'emailAlreadyInUseContent'.tr,
            );
            isLoading = false;
            update();
          }
        } catch (e) {
          Get.snackbar(
            'accountCreationFailedTitle'.tr,
            'accountCreationFailedContent'.tr,
          );
        } finally {
          isLoading = false;
          update();
        }
      } else {
        Get.snackbar(
          'privacyPolicyOffTitle'.tr,
          'privacyPolicyOffContent'.tr,
        );
      }
    }
  }

  // 1. تعريف الكائن بالأسلوب الجديد
final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

Future<void> signInWithGoogle() async {
  try {
    isLoading = true;
    update();

    // تأكد أن المنصة تدعم الـ Authentication الجديد
    if (_googleSignIn.supportsAuthenticate()) {
      
      // في الإصدار 7.2.0، الدالة authenticate ترجع المستخدم مباشرة
      // وهي البديل الرسمي لـ signIn()
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        isLoading = false;
        update();
        return;
      }

      // الحصول على التوكنات للربط مع Firebase
      final googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      // تسجيل الدخول في Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // حفظ البيانات في Firestore (مع التحقق من وجود المستخدم مسبقاً)
        await saveUserToFirestore(firebaseUser);

        // التوجيه للمنيو الرئيسي
        Get.offAllNamed(AppRoutes.navigationMenu);
      }
    } else {
      Get.snackbar('Error', 'Platform not supported');
    }
  } catch (e) {
    print("Google Auth Error: $e");
    Get.snackbar('خطأ', 'فشل تسجيل الدخول: $e');
  } finally {
    isLoading = false;
    update();
  }
}

// دالة الحفظ لضمان عدم تكرار البيانات أو تصفير رقم الغرفة
Future<void> saveUserToFirestore(User user) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
  final docSnapshot = await userDoc.get();

  if (!docSnapshot.exists) {
    // مستخدم جديد: نخزن بياناته الأساسية
    await userDoc.set({
      'userId': user.uid,
      'username': user.displayName ?? "No Name",
      'email': user.email,
      'roomNumber': 0, // افتراضي
      'isActive': false,
      'role': 'user',
      'createAt': Timestamp.now(),
      'provider': 'google',
    });
  } else {
    // مستخدم قديم: نحدث فقط وقت الدخول لكي لا نمسح رقم الغرفة الحالي
    await userDoc.update({
      'lastLogin': Timestamp.now(),
    });
  }
}
// تعريف الكائن باستخدام النظام الجديد
// final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

// Future<void> signInWithGoogle() async {
//   try {
//     isLoading = true;
//     update();

//     // 1. بدء عملية المصادقة (النظام الجديد 7.2.0)
//     if (_googleSignIn.supportsAuthenticate()) {
//       await _googleSignIn.authenticate();
      
//       final googleUser = _googleSignIn.currentUser;

//       if (googleUser == null) {
//         isLoading = false;
//         update();
//         return;
//       }

//       // 2. الحصول على الـ Tokens للربط مع Firebase
//       final googleAuth = await googleUser.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // 3. تسجيل الدخول في Firebase Authentication
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//       User? firebaseUser = userCredential.user;

//       if (firebaseUser != null) {
//         // 4. حفظ البيانات في Cloud Firestore
//         await _saveUserToFirestore(firebaseUser);

//         // 5. التوجه للقائمة الرئيسية
//         Get.offAllNamed(AppRoutes.navigationMenu);
//       }
//     } else {
//       Get.snackbar('Error', 'Platform not supported for direct authentication');
//     }
//   } catch (e) {
//     print("Google Auth Error: $e");
//     Get.snackbar('خطأ', 'فشل تسجيل الدخول: $e');
//   } finally {
//     isLoading = false;
//     update();
//   }
// }

// دالة منفصلة لحفظ البيانات لضمان نظافة الكود
Future<void> _saveUserToFirestore(User user) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
  
  // نتحقق أولاً إذا كان المستخدم موجوداً مسبقاً لكي لا نصفر رقم الغرفة
  final docSnapshot = await userDoc.get();

  if (!docSnapshot.exists) {
    // إذا كان مستخدم جديد تماماً
    await userDoc.set({
      'userId': user.uid,
      'username': user.displayName ?? "No Name",
      'email': user.email,
      'roomNumber': 0, // قيمة افتراضية حتى يتم تعديلها من قبل الإدارة أو الملف الشخصي
      'isActive': false,
      'role': 'user',
      'createAt': Timestamp.now(),
      'provider': 'google',
    });
  } else {
    // إذا كان موجوداً، نحدث فقط آخر وقت لتسجيل الدخول (اختياري)
    await userDoc.update({
      'lastLogin': Timestamp.now(),
    });
  }
}

  @override
  void onInit() {
    roomNumberController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    roomNumberController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
