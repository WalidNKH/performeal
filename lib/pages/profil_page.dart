import 'package:flutter/material.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:performeal/components/profilComponents.dart';
import 'package:performeal/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:performeal/components/customBottomBar.dart';
import 'package:get/get.dart';
import 'package:performeal/components/homeComponents.dart';

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
  final RxInt currentIndex = 1.obs; // Index 4 pour la page profil

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
                  const SizedBox(height: 16),
                  const DateSelector(),
                  const SizedBox(height: 24),
                  const MealTypeSelector(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: const [
                        MealCard(
                          title: 'Salades de crudités',
                          subtitle: 'Tomates et carottes',
                          points: 35,
                          duration: '30 minutes',
                          imageUrl:
                              'assets/images/salade.png', // À remplacer par votre URL
                          isAssetImage: true,
                        ),
                        MealCard(
                          title: 'Poulet roti',
                          subtitle: 'Tomates et carottes',
                          points: 60,
                          duration: '30 minutes',
                          imageUrl:
                              'assets/images/pouletroti.png', // À remplacer par votre URL
                          isAssetImage: true,
                        ),
                        MealCard(
                          title: 'Cookie',
                          subtitle: 'Noisette et chocolat',
                          points: 60,
                          duration: '15 minutes',
                          imageUrl:
                              'assets/images/cookie.png', // À remplacer par votre URL
                          isAssetImage: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomBar(
          currentIndex: currentIndex.value,
          onTap: (index) {
            currentIndex.value = index;
            // Gérer la navigation selon l'index
            switch (index) {
              case 0: // Accueil
                Get.toNamed('/home');
                break;
              case 1: // Repas
                Get.toNamed('/meals');
                break;
              case 3: // Sport
                Get.toNamed('/sports');
                break;
              case 4: // Profil (page actuelle)
                // Déjà sur la page profil, pas besoin de navigation
                break;
            }
          },
        ),
      ),
    );
  }
}

// Painter personnalisé pour la ligne pointillée
