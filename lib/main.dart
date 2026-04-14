import 'dart:developer';
import 'package:chimay_house/core/constant/app_routes.dart';
import 'package:chimay_house/core/localization/local.dart';
import 'package:chimay_house/core/localization/local_controller.getx.dart';
import 'package:chimay_house/core/services/app_services.dart';
import 'package:chimay_house/firebase_options.dart';
import 'package:chimay_house/models/static/reminder_model.dart';
import 'package:chimay_house/modules/auth/chooseLanguage/view/choose_language_view.dart';
import 'package:chimay_house/modules/auth/logic_view/controller/logic_auth_controller.getx.dart';
import 'package:chimay_house/routes.dart';
import 'package:chimay_house/theme/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kIsWeb) {
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }

  tz.initializeTimeZones();
  final String timeZoneName = (await FlutterTimezone.getLocalTimezone()).identifier; 
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  await initialService();

  await initializeDateFormatting();
  
  await Hive.initFlutter();
  Hive.registerAdapter(RemindersModelAdapter());
  await Hive.openBox<RemindersModel>('remindersBox');
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // log(Get.deviceLocale.toString());
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppServices services = Get.find();
    bool isLight = services.sharedPreferences.getBool('lightMode') ?? false;
    Get.put(AppLocalController());
    String? langCode =
        services.sharedPreferences.getString('langCode') ??
        Get.deviceLocale?.languageCode ??
        'en';
    // log(langCode);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      // home: ChooseLanguageView(),
      locale: Locale(langCode.toLowerCase()),
      translations: MyLocal(),
      fallbackLocale: Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
        Locale('ar'),
        Locale('en'),
        // Locale('ku',''),
        // Locale('so'),
        Locale('tr'),
        // Locale('ti',''),
        Locale('nl'),
        Locale('uk'),
        Locale('ps'),
        Locale('es'),
      ],
      getPages: getPages,
      theme: AppTheme.lightMode,
      darkTheme: AppTheme.darkMode,
      themeMode: services.sharedPreferences.getBool('lightMode') == null
          ? ThemeMode.system
          : isLight
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }
}
