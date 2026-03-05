import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class ImportantNumber extends GetxController {}

class ImportantNumberImp extends ImportantNumber {
  RxInt copiedIndex = (-1).obs;
  void copyNumber(int index, String number) async {
    await Clipboard.setData(ClipboardData(text: number));
    copiedIndex.value = index;

    await Future.delayed(Duration(seconds: 3));
    copiedIndex.value = -1;
  }
}
