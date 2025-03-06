import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/button.dart';
import 'package:performeal/controllers/SecondOnboardingController.dart';
import '../auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();

  // state variables
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // void signUp() async {
  //   final email = _emailController.text;
  //   final password = _passwordController.text;
  //   final confirmPassword = _confirmPasswordController.text;

  //   if (password != confirmPassword) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Les mots de passe ne correspondent pas")),
  //     );
  //   }

  //   try {
  //     await authService.signUpWithEmailPassword(email, password);
  //     Get.offAllNamed(profilRoute);
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error: $e")),
  //       );
  //     }
  //   }
  // }

  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Les mots de passe ne correspondent pas")),
      );
      return;
    }

    try {
      // Inscription de l'utilisateur
      await authService.signUpWithEmailPassword(email, password);

      // Récupérer le controller de SecondOnboarding
      final secondOnboardingController = Get.find<SecondOnboardingController>();

      // Sauvegarder les données d'onboarding
      await secondOnboardingController.saveUserData();

      // Navigation vers la page profil (cette ligne peut être supprimée car saveUserData gère déjà la navigation)
      // Get.offAllNamed(profilRoute);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
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
          const SizedBox(height: 10),
          const Text(
            "Confirmation du mot de passe",
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 15,
            ),
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "8 caractères + 1 caractère spécial",
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
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            obscureText: _obscureConfirmPassword,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: CustomButton(
              text: 'Création du compte',
              onPressed: signUp,
              backgroundColor: const Color(0xFFEC661D),
              foregroundColor: Colors.white,
              borderColor: const Color(0xFFEC661D),
              borderWidth: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
