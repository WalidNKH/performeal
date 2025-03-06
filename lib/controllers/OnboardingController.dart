import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  RxInt activePage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      activePage.value = pageController.page?.toInt() ?? 0;
    });
  }

  void nextPage() {
    if (activePage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      activePage.value++;
    }
  }

  void previousPage() {
    if (activePage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      activePage.value--;
    }
  }

  void changePage(int index) {
    pageController.jumpToPage(index);
    activePage.value = index;
  }
}
