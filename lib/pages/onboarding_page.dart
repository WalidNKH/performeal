import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/onboardingSlide.dart';
import 'package:performeal/controllers/OnboardingController.dart';
import 'package:performeal/routes.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: [
          OnboardingSlide(
            imageName: 'p3',
            text: 'Atteignez votre objectif\nsans effort',
            controller: controller,
          ),
          OnboardingSlide(
            imageName: 'p2',
            text: 'Calculez vos calories\nfacilement',
            controller: controller,
          ),
          OnboardingSlide(
            imageName: 'p1',
            text: 'Des recettes pour tous les besoins',
            controller: controller,
            showButton: true,
            onButtonPressed: () {
              Get.toNamed(secondOnboardingRoute);
            },
          )
        ],
      ),
    );
  }
}
