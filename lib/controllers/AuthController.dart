import 'package:get/get.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

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
