import 'package:chimay_house/core/services/app_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

class HelperFunctions {
  //! check is dark mode

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }


  String formatFirestoreTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat("MMMM d, y • h:mm a").format(dateTime);
  }

  String formatSafeDate(Timestamp timestamp) {
      AppServices services = Get.find();
      DateTime dateTime = timestamp.toDate();

      String rawLang =
          services.sharedPreferences.getString('langCode') ??
          Get.deviceLocale?.languageCode ??
          'en';

      List<String> dateSafeLocales = ['en', 'ar', 'fr', 'es', 'tr', 'nl', 'uk'];
      String safeLocale = dateSafeLocales.contains(rawLang) ? rawLang : 'en';

      return DateFormat("MMMM d, y • h:mm a", safeLocale).format(dateTime);
    }

    String formatFirestoreTimestampOnlyDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat("MMMM d, y").format(dateTime);
  }

    String formatFirestoreTimestampOnlyDateDifferentStyle(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat("y-MM-dd").format(dateTime);
  }

  String formatFirestoreTimestampOnlyDateWithNormalStyle(
      Timestamp timestamp,
    ) {
      DateTime dateTime = timestamp.toDate();
      return DateFormat("dd / MM / y").format(dateTime);
    }


  Future<void> launchUrlMethod(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not launch $urlString',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Iconsax.warning_2, color: Colors.white),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }
  
  Future<void> makePhoneCall(String phoneNumber) async {
  final Uri url = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

}
