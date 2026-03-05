
import 'package:chimay_house/models/data/stop_and_think_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class StopAndThinkController extends GetxController {}

class StopAndThinkControllerImp extends StopAndThinkController {
  late PageController pageController;
  int currentPage = 0;
  double currentPercent = 0.10;

  final int totalPages = stopAndThinkData.length;

  void addPercent() {
    currentPercent = ((currentPage + 1) / totalPages).clamp(0.0, 1.0);
    update();
  }

  void jumpToNextSlide() {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      currentPage++;
      addPercent();
    }
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
