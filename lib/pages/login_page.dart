import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:performeal/components/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:performeal/controllers/AuthController.dart';
import 'package:performeal/routes.dart';

class LoginPage extends GetWidget<AuthController> {
  LoginPage({super.key});

  final authService = AuthService();

  // state variables
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEC661D)),
          onPressed: () => Get.back(),
        ),
        backgroundColor: const Color(0xFFFFF8F3), // Même couleur que le fond
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFF8F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 1),
            // Section du milieu avec l'image et le texte
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Image.asset(
                    'assets/images/mascotteconnexion.png',
                    height: 138,
                  ),
                ),
                const Text(
                  "Bienvenue !",
                  style: TextStyle(
                    fontFamily: 'OmnesNarrow',
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  ),
                ),
                const Text(
                  "Connectez-vous pour accéder \n à votre compte Performeal",
                  style: TextStyle(
                      fontFamily: 'Oscine',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.2),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // Section des boutons en bas
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(right: 64, left: 64, bottom: 170),
              children: [
                CustomButton(
                  text: 'Continuer avec Google',
                  onPressed: () async {
                    try {
                      await authService.googleSignIn();
                      Get.offNamed('/home');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Erreur de connexion: ${e.toString()}')),
                      );
                    }
                  },
                  icon: FontAwesomeIcons.google,
                  backgroundColor: Color(0xFFEC661D),
                  foregroundColor: Colors.white,
                  borderWidth: 1,
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Continuer avec mon mail',
                  onPressed: () => Get.toNamed(mailRoute),
                  icon: FontAwesomeIcons.envelope,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFFEC661D),
                  borderColor: Color(0xFFEC661D),
                  borderWidth: 2.0,
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Get.toNamed(registerRoute),
                  child: const Text(
                    "Vous n'avez pas de compte ?",
                    style: TextStyle(
                      fontFamily: 'Oscine',
                      fontSize: 16,
                      decoration:
                          TextDecoration.underline, // Ajoute le soulignage
                      decorationColor:
                          Colors.black, // Même couleur orange que les boutons
                      decorationThickness: 1,
                    ),
                    textAlign: TextAlign.center,
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
