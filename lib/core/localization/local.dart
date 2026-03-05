import 'package:chimay_house/core/localization/language/arabic.dart';
import 'package:chimay_house/core/localization/language/dutch.dart';
import 'package:chimay_house/core/localization/language/english.dart';
import 'package:chimay_house/core/localization/language/espanol.dart';
import 'package:chimay_house/core/localization/language/french.dart';
import 'package:chimay_house/core/localization/language/kurdish.dart';
import 'package:chimay_house/core/localization/language/pashto.dart';
import 'package:chimay_house/core/localization/language/somali.dart';
import 'package:chimay_house/core/localization/language/tigrinya.dart';
import 'package:chimay_house/core/localization/language/turkish.dart';
import 'package:chimay_house/core/localization/language/ukrainian.dart';
import 'package:get/get.dart';


class MyLocal implements Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'ar':arabic,
    'en':english,
    'fr':french,
    'nl':dutch,
    'so':somali,
    'ti':tigrinya,
    'ps':pashto,
    'tr':turkish,
    'uk':ukrainian,
    'es':espanol,
    'ku':kurdish
  };

} 