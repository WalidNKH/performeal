import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/button.dart';
import 'package:performeal/controllers/OnboardingController.dart';

class OnboardingSlide extends StatelessWidget {
  final String imageName;
  final String text;
  final OnboardingController controller;
  final bool showButton;
  final VoidCallback? onButtonPressed;
  const OnboardingSlide({
    super.key,
    required this.imageName,
    required this.text,
    required this.controller,
    this.showButton = false,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF8F3),
      child: Stack(
        // Remplacer Column par Stack
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC234).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.only(top: 45, bottom: 45),
                    child: Center(
                      child: Image.asset('assets/images/$imageName.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Oscine',
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                buildDots(),
                const SizedBox(height: 30),
              ],
            ),
          ),
          if (showButton)
            Positioned(
              right: 20,
              bottom: 80, // Ajuster cette valeur selon vos besoins
              child: CustomButton(
                text: 'Suivant',
                onPressed: onButtonPressed ?? () {},
                width: 120, // Ajuster la largeur selon vos besoins
              ),
            ),
        ],
      ),
    );
  }

  Widget buildDots() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3, // nombre de pages
          (index) => GestureDetector(
            onTap: () => controller.changePage(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.activePage.value == index
                    ? const Color(0xFFEC661D) // Point orange actif
                    : Colors.white, // Points inactifs
                border: Border.all(
                  color: const Color(
                      0xFFEC661D), // Bordure orange pour tous les points
                  width: 1, // Épaisseur de la bordure
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
