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
    'Nederlands',
    'English',
    'العربية',
    'Українська',
    'Türkçe',
    'Español',
    'Kurdî',        
    'Soomaali',
    'ትግርኛ',
    'پښتو',
  ];

  List<String> flags = [
    AppImages.france,
    AppImages.netherlands,
    AppImages.america,
    AppImages.saudiArabia,
    AppImages.ukraine,
    AppImages.turkey,
    AppImages.spain,
    AppImages.kurdistan,
    AppImages.somalia,
    AppImages.eritrea,
    AppImages.afghanistan,
  ];

  List<String> langCode = [
    'fr',
    'nl',
    'en',
    'ar',
    'uk',
    'tr',
    'es',
    'ku',
    'so',
    'ti',
    'ps',
  ];

  @override
  void onInit() {
    getCurrentLanguage();
    super.onInit();
  }
}
