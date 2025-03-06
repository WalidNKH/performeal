import 'package:flutter/material.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:performeal/components/profilComponents.dart';
import 'package:performeal/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  final userService = UserService();
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        final data = await userService.getUserById(userId);
        setState(() {
          userData = data;
        });
        print('=== DONNÉES UTILISATEUR CHARGÉES ===');
        print(userData);
      }
    } catch (e) {
      print('Erreur lors du chargement des données: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors du chargement des données'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3),
      body: SafeArea(
        child: userData == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFEC661D),
                ),
              )
            : Column(
                children: [
                  ProfileHeader(
                    authService: authService,
                    userName: userData!['name'] ?? '',
                  ),
                  if (userData!['deadline'] != null)
                    ProgressTrack(
                      deadline: DateTime.parse(userData!['deadline']),
                    ),
                ],
              ),
      ),
    );
  }
}

// Painter personnalisé pour la ligne pointillée
