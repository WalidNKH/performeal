import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:performeal/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      await _authService.signInWithEmailPassword(email, password);
    } catch (e) {
      Get.snackbar("Error", "Error: $e");
    }
  }

  Future<void> googleLogin() async {
    try {
      await _authService.googleSignIn();
      Get.offNamed(profilRoute);
    } catch (e) {
      Get.snackbar("Error", "Erreur de connexion: $e");
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    await _authService.signInWithEmailPassword(email, password);
  }

  Future<void> signUpWithEmailPassword(String email, String password) async {
    await _authService.signUpWithEmailPassword(email, password);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  String? getCurrentUserEmail() {
    return _authService.getCurrentUserEmail();
  }

  Future<AuthResponse> googleSignIn() async {
    return await _authService.googleSignIn();
  }

  @override
  onInit() {
    super.onInit();
    print("AuthController initialized");
  }

  Future<AuthResponse> signInWithGoogle() async {
    return await _authService.googleSignIn();
  }
}
