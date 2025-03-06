import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:performeal/models/goal_type.dart';
import 'package:performeal/models/restrictions_type.dart';
import 'package:performeal/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/user_service.dart';
import '../models/sport_type.dart';

class SecondOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final UserService _userService = UserService();
  final supabase = Supabase.instance.client;
  // Variables pour stocker les données utilisateur
  final name = ''.obs;
  final age = 20.obs;
  final gender = ''.obs;
  final height = 170.0.obs;
  final weight = 70.0.obs;
  final sport = Rx<SportType>(SportType.autre);
  final goal = Rx<GoalType>(GoalType.mangerSain);
  final basalMetabolicRate = 0.0.obs;

  // Rx<GoalType>? goal;
  // Rx<SportType>? sport;
  // final frequency = ''.obs;
  final restrictions = Rx<RestrictionsType>(RestrictionsType.aucune);
  final weeklySportsCount = 1.obs;
  final competition = false.obs;
  final Rx<DateTime?> deadline = Rx<DateTime?>(null);

  String? userId;

  @override
  void onInit() {
    super.onInit();
    age.value = 20; // S'assure que l'âge est initialisé à 20
    calculateBMR();
  }


  void nextPage() {
    if (pageController.page! < 8) {
      // Nombre total de pages - 1
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Terminer l'onboarding et sauvegarder les données
      saveUserData();
    }
  }

  void previousPage() {
    if (pageController.page! > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> updateUserName(String value) async {
    name.value = value;
    if (userId != null) {
      await _userService.updateName(userId!, value);
    }
    logUserData();
  }

  Future<void> updateUserAge(int? value) async {
    if (value != null) {
      age.value = value;
      if (userId != null) {
        await _userService.updateAge(userId!, value);
      }
    }
    logUserData();
  }

  Future<void> updateUserGender(String value) async {
    gender.value = value;
    if (userId != null) {
      await _userService.updateGender(userId!, value);
    }
    logUserData();
  }

  Future<void> updateUserSport(SportType value) async {
    sport?.value = value;
    if (userId != null) {
      await _userService.updateSport(userId!, value.toDbValue());
    }
    logUserData();
  }

  Future<void> updateUserGoal(GoalType value) async {
    goal?.value = value;
    if (userId != null) {
      await _userService.updateGoal(userId!, value.toDbValue());
    }
    logUserData();
  }

  Future<void> updateWeeklySportsCount(int? value) async {
    if (value != null) {
      weeklySportsCount.value = value;
      if (userId != null) {
        await _userService.updateWeeklySportsCount(userId!, value);
      }
    }
    logUserData();
  }

  Future<void> updateHeight(double? value) async {
    if (value != null) {
      height.value = value;
      calculateBMR();
      if (userId != null) {
        await _userService.updateHeight(userId!, value);
      }
    }
    logUserData();
  }

  Future<void> updateWeight(double? value) async {
    if (value != null) {
      weight.value = value;
      calculateBMR();
      if (userId != null) {
        await _userService.updateWeight(userId!, value);
      }
    }
    logUserData();
  }

  void calculateBMR() {
    if (weight.value > 0 &&
        height.value > 0 &&
        age.value > 0 &&
        gender.value.isNotEmpty) {
      // Formule de Mifflin-St Jeor pour le métabolisme de base (MB)
      double bmr;
      if (gender.value.toLowerCase() == 'homme') {
        bmr = (10 * weight.value) + (6.25 * height.value) - (5 * age.value) + 5;
      } else {
        bmr =
            (10 * weight.value) + (6.25 * height.value) - (5 * age.value) - 161;
      }

      // Facteur d'activité physique basé sur weeklySportsCount
      double activityFactor;
      if (weeklySportsCount.value == 0) {
        activityFactor = 1.2; // Sédentaire
      } else if (weeklySportsCount.value <= 3) {
        activityFactor = 1.375; // Légèrement actif
      } else if (weeklySportsCount.value <= 5) {
        activityFactor = 1.55; // Actif
      } else if (weeklySportsCount.value <= 7) {
        activityFactor = 1.725; // Très actif
      } else {
        activityFactor = 1.9; // Extrêmement actif
      }

      // Calcul du BMR final avec le facteur d'activité
      basalMetabolicRate.value = bmr * activityFactor;
      print(
          'BMR calculé avec activité: ${basalMetabolicRate.value.toStringAsFixed(2)} calories');
    }
  }

  // Dans votre SecondOnboardingController
  Future<void> updateUserRestrictions(RestrictionsType value) async {
    try {
      restrictions.value = value;
      if (userId != null) {
        await _userService.updateRestrictions(userId!, value.toDbValue());
        print('Restrictions mises à jour: ${value.toDbValue()}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour des restrictions: $e');
      // Vous pouvez ajouter ici une gestion d'erreur plus sophistiquée si nécessaire
    }
    logUserData();
  }

  Future<void> updateDeadline(DateTime value) async {
    try {
      deadline.value = value;
      if (userId != null) {
        await _userService.updateDeadline(userId!, value);
        print('Deadline mise à jour: $value');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de la deadline: $e');
    }
    logUserData();
  }

  Future<void> updateCompetition(bool value) async {
    competition.value = value;
    if (userId != null) {
      await _userService.updateCompetitionStatus(userId!, value);
    }
    logUserData();
  }

  // Future<void> saveUserData() async {
  //   try {
  //     if (userId == null) {
  //       // Création initiale de l'utilisateur
  //       final userData = await _userService.createUser({
  //         'name': name.value,
  //         'age': age.value,
  //         'gender': gender.value,
  //         'sport': sport?.value.toDbValue(),
  //         'goal': goal?.value.toDbValue(),
  //         'weekly_sports_count': weeklySportsCount.value,
  //         'competition': competition.value,
  //       });
  //       userId = userData['id'];
  //     }

  //     // Calculer et mettre à jour le BMR si toutes les données nécessaires sont présentes
  //     if (userId != null && age.value != null && gender.value.isNotEmpty) {
  //       await _userService.calculateAndUpdateBMR(userId!);
  //     }

  //     // Navigation vers la page suivante
  //     Get.toNamed('/home');
  //   } catch (e) {
  //     print('Erreur lors de la sauvegarde des données: $e');
  //     // Gérer l'erreur (par exemple, afficher un message à l'utilisateur)
  //   }
  // }

  // Future<void> saveUserData() async {
  //   try {
  //     // Vérification des données obligatoires
  //     if (name.value.isEmpty ||
  //         age.value == null ||
  //         gender.value.isEmpty ||
  //         sport?.value == null ||
  //         goal?.value == null ||
  //         height.value == null ||
  //         weight.value == null ||
  //         deadline.value == null) {
  //       Get.snackbar(
  //         'Erreur',
  //         'Veuillez remplir tous les champs obligatoires',
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //       return;
  //     }
  //     calculateBMR();
  //     // Préparation des données utilisateur
  //     final Map<String, dynamic> userData = {
  //       'name': name.value,
  //       'age': age.value,
  //       'gender': gender.value,
  //       'height': height.value,
  //       'weight': weight.value,
  //       'sport': sport!.value.toDbValue(),
  //       'goal': goal!.value.toDbValue(),
  //       'weekly_sports_count': weeklySportsCount.value,
  //       'deadline': deadline.value?.toIso8601String(),
  //       'competition': competition.value,
  //       'basal_metabolic_rate': basalMetabolicRate.value,
  //       'restrictions': restrictions?.value?.toDbValue() ?? 'Aucune',
  //       'api_connected': false, // Par défaut
  //       'created_at': DateTime.now().toIso8601String(),
  //     };

  //     if (userId == null) {
  //       // Création initiale de l'utilisateur
  //       final response = await _userService.createUser(userData);
  //       userId = response['id'];
  //     } else {
  //       // Mise à jour de l'utilisateur existant
  //       await _userService.updateUser(userId!, userData);
  //     }
  //     // Afficher un message de succès
  //     Get.snackbar(
  //       'Succès',
  //       'Votre profil a été créé avec succès !',
  //       backgroundColor: const Color(0xFFFF7E1D),
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: const Duration(seconds: 2),
  //     );

  //     // Attendre que le message soit affiché avant de naviguer
  //     await Future.delayed(const Duration(seconds: 2));

  //     // Navigation vers la page d'accueil
  //     Get.offAllNamed('/home');
  //   } catch (e) {
  //     print('Erreur lors de la sauvegarde des données: $e');
  //     Get.snackbar(
  //       'Erreur',
  //       'Une erreur est survenue lors de la sauvegarde de vos données',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
  Future<void> saveUserData() async {
    try {
      // Récupérer l'ID de l'utilisateur authentifié
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) {
        Get.snackbar(
          'Erreur',
          'Veuillez vous connecter d\'abord',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Préparation des données utilisateur
      final Map<String, dynamic> userData = {
        'name': name.value,
        'age': age.value,
        'gender': gender.value,
        'height': height.value,
        'weight': weight.value,
        'sport': sport!.value.toDbValue(),
        'goal': goal!.value.toDbValue(),
        'weekly_sports_count': weeklySportsCount.value,
        'deadline': deadline.value?.toIso8601String(),
        'competition': competition.value,
        'basal_metabolic_rate': basalMetabolicRate.value,
        'restrictions': restrictions?.value?.toDbValue() ?? 'Aucune',
      };

      // Mettre à jour l'utilisateur existant en utilisant directement l'id
      await supabase
          .from('users')
          .update(userData)
          .eq('id', currentUser.id); // Utilisation directe de l'id

      // Afficher un message de succès
      Get.snackbar(
        'Succès',
        'Vos données ont été sauvegardées !',
        backgroundColor: const Color(0xFFFF7E1D),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigation vers la page d'inscription
      Get.toNamed(profilRoute);
    } catch (e) {
      print('Erreur lors de la mise à jour des données: $e');
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de la mise à jour de vos données',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void logUserData() {
    print('''
=== DONNÉES UTILISATEUR ===
Nom: ${name.value}
Âge: ${age.value} ans
Genre: ${gender.value}
Taille: ${height.value} cm
Poids: ${weight.value} kg
BMR: ${basalMetabolicRate.value.toStringAsFixed(2)} calories
Sport: ${sport.value.toDbValue()}
Objectif: ${goal.value.toDbValue()}
Fréquence: ${weeklySportsCount.value} séances par semaine
Restrictions: ${restrictions.value.toDbValue()}
Compétition: ${competition.value}
Date limite: ${deadline.value?.toIso8601String() ?? 'Aucune'}
=========================
''');
  }
}
