import 'package:performeal/models/users_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Singleton pattern
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  static const String _tableName = 'users';

  // Créer un nouvel utilisateur
  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      final response =
          await _supabase.from(_tableName).insert(userData).select().single();

      return response;
    } catch (e) {
      throw 'Erreur lors de la création de l\'utilisateur: $e';
    }
  }

  // Récupérer un utilisateur par son ID
  Future<Map<String, dynamic>> getUserById(String userId) async {
    try {
      final response =
          await _supabase.from(_tableName).select().eq('id', userId).single();

      return response;
    } catch (e) {
      throw 'Erreur lors de la récupération de l\'utilisateur: $e';
    }
  }

  // Mettre à jour un utilisateur
  Future<Map<String, dynamic>> updateUser(
      String userId, Map<String, dynamic> updates) async {
    try {
      final response = await _supabase
          .from(_tableName)
          .update(updates)
          .eq('id', userId)
          .select()
          .single();

      return response;
    } catch (e) {
      throw 'Erreur lors de la mise à jour de l\'utilisateur: $e';
    }
  }

  // Mettre à jour l'âge
  Future<void> updateAge(String userId, int age) async {
    await updateUser(userId, {'age': age});
  }

  // Mettre à jour le nom
  Future<void> updateName(String userId, String name) async {
    await updateUser(userId, {'name': name});
  }

  // Mettre à jour le genre
  Future<void> updateGender(String userId, String gender) async {
    await updateUser(userId, {'gender': gender});
  }

  // Mettre à jour le sport
  Future<void> updateSport(String userId, String sport) async {
    await updateUser(userId, {'sport': sport});
  }

  // Mettre à jour l'objectif
  // Dans la classe UserService
  Future<void> updateGoal(String userId, String goal) async {
    await updateUser(userId, {'goal': goal});
  }

  // Mettre à jour le nombre de séances hebdomadaires
  Future<void> updateWeeklySportsCount(String userId, int count) async {
    await updateUser(userId, {'weekly_sports_count': count});
  }

  // Mettre à jour la taille
  Future<void> updateHeight(String userId, double height) async {
    await updateUser(userId, {'height': height});
  }

  // Mettre à jour le poids
  Future<void> updateWeight(String userId, double weight) async {
    await updateUser(userId, {'weight': weight});
  }

  // Ajouter cette méthode dans votre UserService
  Future<void> updateRestrictions(String userId, String restrictions) async {
    try {
      await _supabase
          .from(_tableName)
          .update({'restrictions': restrictions}).eq('id', userId);
    } catch (e) {
      throw 'Erreur lors de la mise à jour des restrictions: $e';
    }
  }

  Future<void> updateDeadline(String userId, DateTime deadline) async {
    try {
      await _supabase
          .from(_tableName)
          .update({'deadline': deadline.toIso8601String()}).eq('id', userId);
    } catch (e) {
      throw 'Erreur lors de la mise à jour de la deadline: $e';
    }
  }

  // Mettre à jour le statut de compétition
  Future<void> updateCompetitionStatus(String userId, bool isCompetitor) async {
    await updateUser(userId, {'competition': isCompetitor});
  }

  // Mettre à jour la date limite
  // Future<void> updateDeadline(String userId, DateTime deadline) async {
  //   await updateUser(userId, {'deadline': deadline.toIso8601String()});
  // }

  // Supprimer un utilisateur
  Future<void> deleteUser(String userId) async {
    try {
      await _supabase.from(_tableName).delete().eq('id', userId);
    } catch (e) {
      throw 'Erreur lors de la suppression de l\'utilisateur: $e';
    }
  }

  // Calculer et mettre à jour le BMR
  Future<void> calculateAndUpdateBMR(String userId) async {
    try {
      final userData = await getUserById(userId);
      final user = UserModel.fromJson(userData);
      final bmr = user.calculateBMR();
      await updateUser(userId, {'basal_metabolic_rate': bmr});
    } catch (e) {
      throw 'Erreur lors du calcul et de la mise à jour du BMR: $e';
    }
  }
}
