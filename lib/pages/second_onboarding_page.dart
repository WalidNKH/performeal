import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/secondOnboardingSlide.dart';
import 'package:performeal/controllers/SecondOnboardingController.dart';

class SecondOnboardingPage extends StatelessWidget {
  const SecondOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecondOnboardingController());

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Empêche le swipe manuel
        children: [
          // Slide prénom
          UserDataSlide(
            imageName: 'mascotteconnexion',
            title: 'Bienvenue',
            content: NameInputContent(controller: controller),
            controller: controller,
          ),
          // Slide âge
          Obx(
            () => UserDataSlide(
              imageName: 'p12',
              title: 'Bonjour ${controller.name.value}',
              content: AgeInputContent(controller: controller),
              controller: controller,
              showUsername: true,
            ),
          ),
          UserDataSlide(
            imageName: 'p9',
            // title: 'Bonjour ${controller.name.value}',
            content: GenderInputContent(controller: controller),
            controller: controller,
          ),
          UserDataSlide(
            imageName: 'p5',
            // title: 'Bonjour ${controller.name.value}',
            content: FrequenceInputContent(controller: controller),
            controller: controller,
          ),
          UserDataSlide(
            imageName: 'p11',
            // title: 'Bonjour ${controller.name.value}',
            content: HeightInputContent(controller: controller),
            controller: controller,
          ),
          UserDataSlide(
            imageName: 'p4',
            // title: 'Bonjour ${controller.name.value}',
            content: WeightInputContent(controller: controller),
            controller: controller,
          ),
          UserDataSlide(
            imageName: 'p4',
            content: WeightGoalInputContent(controller: controller),
            controller: controller,
          ),
          UserDataSlide(
            imageName: 'p8',
            // title: 'Bonjour ${controller.name.value}',
            content: SportInputContent(controller: controller),
            controller: controller,
          ),
          UserDataSlide(
            imageName: 'p10',
            // title: 'Bonjour ${controller.name.value}',
            content: RestrictionsInputContent(controller: controller),
            controller: controller,
          ),
          Obx(
            () {
              return UserDataSlide(
                imageName: 'p10',
                title: 'Bienvenue ${controller.name.value}',
                content: DeadlineInputContent(controller: controller),
                controller: controller,
                isLastSlide: true,
              );
            },
          )
        ],
      ),
    );
  }
}
