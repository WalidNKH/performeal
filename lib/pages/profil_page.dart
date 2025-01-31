import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:performeal/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  void logout() async {
    await authService.signOut();
    Get.offAllNamed(initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Text(authService.getCurrentUserEmail() ??
              "Aucun utilisateur connecté")),
    );
  }
}
