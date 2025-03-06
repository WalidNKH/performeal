import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/button.dart';
import 'package:performeal/routes.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3), // Même couleur que le fond
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    left: 47,
                    top: 0,
                    child: Image.asset(
                      'assets/images/performeal-orange.png',
                      height: 250,
                    ),
                  ),
                  const Positioned(
                    left: 40,
                    bottom: 35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text(
                        "Mieux manger pour mieux \nperformer !",
                        style: TextStyle(
                          fontFamily: 'Oscine',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: CustomButton(
                          text: 'Commencer',
                          onPressed: () {
                            Get.toNamed(onboardingRoute);
                          },
                          backgroundColor: const Color(0xFFEC661D),
                          foregroundColor: Colors.white,
                          borderColor: const Color(0xFFEC661D),
                          borderWidth: 1.0,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Déjà un compte ?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Oscine',
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 135,
                            height: 40,
                            child: CustomButton(
                              text: 'Connectez-vous',
                              onPressed: () => Get.toNamed(loginRoute),
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFFEC661D),
                              borderColor: const Color(0xFFEC661D),
                              borderWidth: 2.0,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Oscine',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -45,
                  left: 117,
                  child: Image.asset(
                    'assets/images/mascotteconnexion.png',
                    height: 125,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
