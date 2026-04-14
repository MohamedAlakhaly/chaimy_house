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
