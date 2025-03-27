import 'sport_type.dart';
import 'goal_type.dart';

class UserModel {
  final String id;
  final String email;
  final String passwordHash;
  final String name;
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final double? weight_goal;
  final double? basalMetabolicRate;
  final GoalType? goal;
  final SportType sport;
  final bool competition;
  final int weeklySportsCount;
  final DateTime? deadline;
  final bool apiConnected;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.name,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.weight_goal,
    this.basalMetabolicRate,
    this.goal,
    required this.sport,
    this.competition = false,
    this.weeklySportsCount = 0,
    this.deadline,
    this.apiConnected = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Création depuis un Map (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      passwordHash: json['password_hash'],
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      height: json['height']?.toDouble(),
      weight: json['weight']?.toDouble(),
      weight_goal: json['weight_goal']?.toDouble(),
      basalMetabolicRate: json['basal_metabolic_rate']?.toDouble(),
      goal: GoalType.fromDbValue(json['goal']),
      sport: SportType.fromDbValue(json['sport']),
      competition: json['competition'] ?? false,
      weeklySportsCount: json['weekly_sports_count'] ?? 0,
      deadline:
          json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      apiConnected: json['api_connected'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  // Conversion en Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password_hash': passwordHash,
      'name': name,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'weight_goal': weight_goal,
      'basal_metabolic_rate': basalMetabolicRate,
      'goal': goal,
      'sport': sport.toDbValue(),
      'competition': competition,
      'weekly_sports_count': weeklySportsCount,
      'deadline': deadline?.toIso8601String(),
      'api_connected': apiConnected,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // Copie avec modifications
  UserModel copyWith({
    String? id,
    String? email,
    String? passwordHash,
    String? name,
    int? age,
    String? gender,
    double? height,
    double? weight,
    double? basalMetabolicRate,
    GoalType? goal,
    SportType? sport,
    bool? competition,
    int? weeklySportsCount,
    DateTime? deadline,
    bool? apiConnected,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      weight_goal: weight_goal ?? this.weight_goal,
      basalMetabolicRate: basalMetabolicRate ?? this.basalMetabolicRate,
      goal: goal ?? this.goal,
      sport: sport ?? this.sport,
      competition: competition ?? this.competition,
      weeklySportsCount: weeklySportsCount ?? this.weeklySportsCount,
      deadline: deadline ?? this.deadline,
      apiConnected: apiConnected ?? this.apiConnected,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Calculer le BMR (Basal Metabolic Rate)
  double calculateBMR() {
    if (weight == null || height == null || age == null || gender == null) {
      throw Exception('Données manquantes pour calculer le BMR');
    }

    // Formule de Mifflin-St Jeor
    double bmr;
    if (gender!.toLowerCase() == 'male') {
      bmr = (10 * weight!) + (6.25 * height!) - (5 * age!) + 5;
    } else {
      bmr = (10 * weight!) + (6.25 * height!) - (5 * age!) - 161;
    }

    return bmr;
  }
}
