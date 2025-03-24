import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mock_supabase_http_client/mock_supabase_http_client.dart';
import 'package:performeal/controllers/SecondOnboardingController.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final SupabaseClient mockSupabase;
  late final MockSupabaseHttpClient mockHttpClient;

  group('SecondOnboardingController - calculateBMR Tests', () {
    late SecondOnboardingController controller;

    setUpAll(() async {
      mockHttpClient = MockSupabaseHttpClient();
      // Configuration des shared preferences pour les tests
      SharedPreferences.setMockInitialValues({});

      mockSupabase = await SupabaseClient(
        'https://mock.test.co',
        'mock_anon_key',
        httpClient: mockHttpClient,
      );
      // Initialisation du controller
      controller = SecondOnboardingController();
    });

    tearDown(() async {
      Get.reset();

      mockHttpClient.reset();
    });

    test('BMR calculation for sedentary male', () async {
      // Arrange
      controller.gender.value = 'homme';
      controller.age.value = 30;
      controller.weight.value = 70;
      controller.height.value = 175;
      controller.weeklySportsCount.value = 0; // Sédentaire

      // Act
      controller.calculateBMR();

      // Assert
      // BMR = (10 × 70) + (6.25 × 175) - (5 × 30) + 5
      // = 700 + 1093.75 - 150 + 5 = 1648.75
      // Avec facteur d'activité sédentaire (1.2)
      // 1648.75 × 1.2 = 1978.5
      expect(controller.basalMetabolicRate.value, closeTo(1978.5, 0.1));
    });

    test('BMR calculation for moderately active female', () async {
      // Arrange
      controller.gender.value = 'femme';
      controller.age.value = 25;
      controller.weight.value = 60;
      controller.height.value = 165;
      controller.weeklySportsCount.value = 3; // Légèrement actif

      // Act
      controller.calculateBMR();

      // Assert
      // BMR = (10 × 60) + (6.25 × 165) - (5 × 25) - 161
      // = 600 + 1031.25 - 125 - 161 = 1345.25
      // Avec facteur d'activité légèrement actif (1.375)
      // 1345.25 × 1.375 = 1849.72
      expect(controller.basalMetabolicRate.value, closeTo(1849.72, 0.1));
    });

    test('BMR calculation for very active male', () async {
      // Arrange
      controller.gender.value = 'homme';
      controller.age.value = 28;
      controller.weight.value = 80;
      controller.height.value = 180;
      controller.weeklySportsCount.value = 6; // Très actif

      // Act
      controller.calculateBMR();

      // Assert
      // BMR = (10 × 80) + (6.25 × 180) - (5 × 28) + 5
      // = 800 + 1125 - 140 + 5 = 1790
      // Avec facteur d'activité très actif (1.725)
      // 1790 × 1.725 = 3087.75
      expect(controller.basalMetabolicRate.value, closeTo(3087.75, 0.1));
    });

    test('BMR calculation for extremely active female', () async {
      // Arrange
      controller.gender.value = 'femme';
      controller.age.value = 22;
      controller.weight.value = 55;
      controller.height.value = 170;
      controller.weeklySportsCount.value = 8; // Extrêmement actif

      // Act
      controller.calculateBMR();

      // Assert
      // BMR = (10 × 55) + (6.25 × 170) - (5 × 22) - 161
      // = 550 + 1062.5 - 110 - 161 = 1341.5
      // Avec facteur d'activité extrêmement actif (1.9)
      // 1341.5 × 1.9 = 2548.85
      expect(controller.basalMetabolicRate.value, closeTo(2548.85, 0.1));
    });

    test('BMR should be 0 when required data is missing', () async {
      // Arrange
      controller.gender.value = '';

      // Act
      controller.calculateBMR();

      // Assert
      expect(controller.basalMetabolicRate.value, equals(0.0));
    });

    test('BMR calculation with invalid values should not crash', () async {
      // Arrange
      controller.gender.value = 'homme';
      controller.age.value = -30;
      controller.weight.value = -70;
      controller.height.value = -175;
      controller.weeklySportsCount.value = -1;

      // Act & Assert
      expect(() => controller.calculateBMR(), returnsNormally);
    });
  });
}
