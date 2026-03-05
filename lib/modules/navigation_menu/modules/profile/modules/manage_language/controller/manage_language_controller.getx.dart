import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/localization/local_controller.getx.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:get/get.dart';

abstract class ManageLanguageController extends GetxController {}

class ManageLanguageControllerImp extends ManageLanguageController {
  AppServices services = Get.find();

  //? this variable take a app language code
  String currentLanguage = '';
  //? this variable will hold the current language selected by the user
  String selectedLanguage = '';
  //? this variable the same as currentLanguage but the different it's for a display button win the start page
  String appLanguage = '';

  void getCurrentLanguage() {
    currentLanguage = services.sharedPreferences.getString('langCode')!;
    appLanguage = services.sharedPreferences.getString('langCode')!;
  }

  void changeLanguage({required String langCode}) {
    services.sharedPreferences.setString('langCode', langCode);
    AppLocalController().changeLocal(langCode);
    Get.back();
    Get.snackbar(
      'successLanguageChangeMessageTitle'.tr,
      'successLanguageChangeMessageContent'.tr,
    );
  }

  List<String> languages = [
    'Français',
    'العربية',
    'English',
    'Kurdî',
    'Soomaali',
    'Türkçe',
    'ትግርኛ',
    'Nederlands',
    'Українська',
    'پښتو',
    'Español',
  ];
  List<String> flags = [
    AppImages.france,
    AppImages.saudiArabia,
    AppImages.america,
    AppImages.kurdistan,
    AppImages.somalia,
    AppImages.turkey,
    AppImages.eritrea,
    AppImages.netherlands,
    AppImages.ukraine,
    AppImages.afghanistan,
    AppImages.spain,
  ];
  List<String> langCode = [
    'fr',
    'ar',
    'en',
    'ku',
    'so',
    'tr',
    'ti',
    'nl',
    'uk',
    'ps',
    'es',
  ];

  @override
  void onInit() {
    getCurrentLanguage();
    super.onInit();
  }
}
