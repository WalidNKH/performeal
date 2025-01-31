import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/button.dart';
import 'package:performeal/routes.dart';
import '../auth/auth_service.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
      // Utilisation de la route définie
      Get.offAllNamed(profilRoute);
    } catch (e) {
      Get.snackbar(
        'Erreur',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEC661D)),
          onPressed: () => Get.back(),
        ),
        backgroundColor: const Color(0xFFFf0f4c4), // Même couleur que le fond
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFf0f4c4),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/mascotteconnexion.png',
                width: 65,
                height: 65,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            "Email",
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 15,
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "mail@gmail.com",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFEC661D)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Mot de passe",
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 15,
            ),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Mot de passe",
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFEC661D)),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Connexion',
            onPressed: signIn,
            backgroundColor: const Color(0xFFEC661D),
            foregroundColor: Colors.white,
            borderColor: const Color(0xFFEC661D),
            borderWidth: 1.0,
          ),
        ],
      ),
    );
  }
}
