import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:performeal/models/goal_type.dart';
import 'package:performeal/models/restrictions_type.dart';
import '../models/sport_type.dart';

class TestController extends GetxController {
  final PageController pageController = PageController();
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
}
