import 'package:get/get.dart';
import 'package:chimay_house/core/constant/app_images.dart';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:rive/rive.dart';

abstract class ChooseLanguageController extends GetxController {}

class ChooseLanguageControllerImp extends ChooseLanguageController {
  AppServices services = Get.find();
  String selectLanguage = 'select language'.tr;
  String currentLanguage = '';
  late RiveAnimationController robotController;

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
  

  void chooseLanguage() async {
    if (currentLanguage == '') {
      selectLanguage = 'mandatory language selection'.tr;
      update();
    } else {
      services.sharedPreferences.setString('langCode', currentLanguage);
      services.sharedPreferences.setBool('hasChosenLanguage', true);
      Get.offNamed(AppRoutes.onBoarding);
    }
  }

  @override
  void onInit() {
    // robotController.isActive = true;
    robotController = SimpleAnimation('Face Idle');
    // getLong();
    super.onInit();
  }
}
