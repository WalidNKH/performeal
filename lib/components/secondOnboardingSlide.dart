import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/components/button.dart';
import 'package:performeal/controllers/SecondOnboardingController.dart';
import 'package:performeal/models/goal_type.dart';
import 'package:performeal/models/sport_type.dart';
import 'package:performeal/models/restrictions_type.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:performeal/routes.dart';

class UserDataSlide extends StatelessWidget {
  final String? imageName;
  final String? title;
  final Widget content;
  final SecondOnboardingController controller;
  final bool showUsername;
  final bool isLastSlide;
  const UserDataSlide({
    super.key,
    this.imageName,
    this.title,
    required this.content,
    required this.controller,
    this.showUsername = false,
    this.isLastSlide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFF8F3),
            border: Border.all(
              color: const Color(0xFFF6B12D),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF6B12D).withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFF6B12D)),
            onPressed: () => controller.previousPage(),
            padding: EdgeInsets.zero,
          ),
        ),
        backgroundColor: const Color(0xFFFFF8F3),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFF8F3),
      body: Container(
        color: const Color(0xFFFFF8F3),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            if (imageName != null) ...[
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset('assets/images/$imageName.png'),
                ),
              ),
              // const SizedBox(height: 20),
            ],
            // const SizedBox(height: 20),
            Text(
              title ?? '',
              style: const TextStyle(
                fontFamily: 'OmnesNarrow',
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 0),
            Expanded(child: content),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: CustomButton(
                text: isLastSlide ? 'Finaliser' : 'Suivant',
                onPressed: () => isLastSlide
                    ? Get.toNamed(registerRoute)
                    : controller.nextPage(),
                fullWidth: true,
                icon: isLastSlide ? Icons.emoji_events_outlined : null,
                style: const TextStyle(
                  fontFamily: 'Oscine',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const NameInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Comment dois-je t\'appeler ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: 'Votre prénom',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF7E1D)),
            ),
          ),
          cursorColor: const Color(0xFFFF7E1D),
          onChanged: (value) => controller.updateUserName(value),
        ),
      ],
    );
  }
}

class AgeInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const AgeInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Création de la liste des âges de 16 à 60
    final List<int> ages = List.generate(48, (index) => index + 13);

    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quel âge as-tu ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Obx(() => DropdownButtonFormField<int>(
              value: controller.age.value ?? 20, // Valeur par défaut : 20 ans
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFFF7E1D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontFamily: 'Oscine',
              ),
              dropdownColor: Colors.white,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFFFF7E1D),
              ),
              items: ages.map((int age) {
                return DropdownMenuItem<int>(
                  value: age,
                  child: Text(
                    '$age ans',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Oscine',
                    ),
                  ),
                );
              }).toList(),
              onChanged: (int? value) {
                if (value != null) {
                  controller.updateUserAge(value);
                }
              },
            )),
      ],
    );
  }
}

class GenderInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const GenderInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quel est ton genre ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildGenderButton(context, 'male', 'Homme', controller),
            _buildGenderButton(context, 'female', 'Femme', controller),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton(BuildContext context, String value, String label,
      SecondOnboardingController controller) {
    return Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.gender.value == value
                ? const Color(0xFFFF7E1D)
                : Colors.grey[300],
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => controller.updateUserGender(value),
          child: Obx(
            () => Text(
              label,
              style: TextStyle(
                color: controller.gender.value == value
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ));
  }
}

class SportInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const SportInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quel sport pratiques-tu principalement ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: SportType.values.length,
            itemBuilder: (context, index) {
              final sport = SportType.values[index];
              return Obx(() => GestureDetector(
                    onTap: () => controller.updateUserSport(sport),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: controller.sport?.value == sport
                            ? const Color(0xFFFF7E1D)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: controller.sport?.value == sport
                              ? const Color(0xFFFF7E1D)
                              : Colors.grey.withOpacity(0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: controller.sport?.value == sport
                                ? const Color(0xFFFF7E1D).withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getIconForSport(sport),
                            size: 32,
                            color: controller.sport?.value == sport
                                ? Colors.white
                                : const Color(0xFFFF7E1D),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            sport
                                .toDbValue()
                                .split(' ')
                                .map((word) =>
                                    word[0].toUpperCase() + word.substring(1))
                                .join(' '), //
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Oscine',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: controller.sport?.value == sport
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }

  IconData _getIconForSport(SportType sport) {
    switch (sport) {
      case SportType.courseAPied:
        return Icons.directions_run;
      case SportType.natation:
        return Icons.pool;
      case SportType.cyclisme:
        return Icons.directions_bike;
      case SportType.tennis:
        return Icons.sports_tennis;
      case SportType.football:
        return Icons.sports_soccer;
      case SportType.basketball:
        return Icons.sports_basketball;
      case SportType.musculation:
        return Icons.fitness_center;
      case SportType.yoga:
        return Icons.self_improvement;
      case SportType.marathon:
        return Icons.timer;
      case SportType.triathlon:
        return Icons.sports;
      case SportType.escalade:
        return Icons.terrain;
      case SportType.danse:
        return Icons.music_note;
      case SportType.boxe:
        return Icons.sports_mma;
      case SportType.rugby:
        return Icons.sports_rugby;
      case SportType.juJitsu:
        return Icons.sports_kabaddi;
      case SportType.mma:
        return Icons.sports_martial_arts;
      case SportType.grappling:
        return Icons.sports_kabaddi;
      case SportType.handball:
        return Icons.sports_handball;
      case SportType.autre:
        return Icons.more_horiz;
      case SportType.aucun:
        return Icons.not_interested;
    }
  }
}

class WeightGoalInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const WeightGoalInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quel est ton poids visé ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xFFFF7E1D),
                iconSize: 32,
                onPressed: () {
                  if (controller.weight_goal.value > 40) {
                    controller
                        .updateWeightGoal(controller.weight_goal.value - 0.5);
                  }
                },
              ),
              const SizedBox(width: 20),
              Obx(() => Text(
                    '${controller.weight_goal.value.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'Oscine',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFFFF7E1D),
                iconSize: 32,
                onPressed: () {
                  if (controller.weight_goal.value < 150) {
                    controller
                        .updateWeightGoal(controller.weight_goal.value + 0.5);
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Afficher la différence avec le poids actuel
        Obx(() {
          final difference =
              controller.weight_goal.value - controller.weight.value;
          final absValue = difference.abs();
          final sign = difference > 0 ? '+' : '-';
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8F3),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: const Color(0xFFFF7E1D).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Text(
                  'Différence avec le poids actuel',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Oscine',
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$sign${absValue.toStringAsFixed(1)} kg',
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'Oscine',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7E1D),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class ObjectifInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const ObjectifInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quel est ton objectif ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<GoalType>(
          value: controller.goal?.value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFFF7E1D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'Oscine',
          ),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Color(0xFFFF7E1D),
          ),
          items: GoalType.values.map((GoalType goal) {
            return DropdownMenuItem<GoalType>(
              value: goal,
              child: Text(
                goal.toDbValue(),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Oscine',
                ),
              ),
            );
          }).toList(),
          onChanged: (GoalType? value) {
            if (value != null) {
              controller.updateUserGoal(value);
            }
          },
        ),
      ],
    );
  }
}

class FrequenceInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const FrequenceInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Combien de fois par semaine peux-tu t\'entraîner ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                color: const Color(0xFFFF7E1D),
                onPressed: () {
                  if (controller.weeklySportsCount.value > 0) {
                    controller.updateWeeklySportsCount(
                        controller.weeklySportsCount.value - 1);
                  }
                },
              ),
              Obx(() => Text(
                    '${controller.weeklySportsCount.value} séances',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Oscine',
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              IconButton(
                icon: const Icon(Icons.add),
                color: const Color(0xFFFF7E1D),
                onPressed: () {
                  if (controller.weeklySportsCount.value < 7) {
                    controller.updateWeeklySportsCount(
                        controller.weeklySportsCount.value + 1);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class HeightInputContent extends StatelessWidget {
//   final SecondOnboardingController controller;

//   const HeightInputContent({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             'Quelle est ta taille ?',
//             style: TextStyle(
//               fontFamily: 'Oscine',
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         const SizedBox(height: 30),
//         Obx(() => Text(
//               '${controller.height.value.toInt()} cm',
//               style: const TextStyle(
//                 fontSize: 40,
//                 fontFamily: 'Oscine',
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFFFF7E1D),
//               ),
//             )),
//         const SizedBox(height: 20),
//         Obx(() => SliderTheme(
//               data: SliderThemeData(
//                 activeTrackColor: const Color(0xFFFF7E1D),
//                 inactiveTrackColor: const Color(0xFFFF7E1D).withOpacity(0.2),
//                 thumbColor: const Color(0xFFFF7E1D),
//                 overlayColor: const Color(0xFFFF7E1D).withOpacity(0.2),
//                 trackHeight: 8,
//                 thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
//                 overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
//               ),
//               child: Slider(
//                 value: controller.height.value,
//                 min: 140,
//                 max: 220,
//                 divisions: 80,
//                 onChanged: (value) => controller.updateHeight(value),
//               ),
//             )),
//         const SizedBox(height: 10),
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('140 cm', style: TextStyle(color: Colors.grey)),
//             Text('220 cm', style: TextStyle(color: Colors.grey)),
//           ],
//         ),
//       ],
//     );
//   }
// }

class HeightInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const HeightInputContent({super.key, required this.controller});

  String getHeightComment(double height) {
    if (height >= 200) {
      return "Tu touches le ciel ! 🌟";
    } else if (height >= 190) {
      return "La vie est belle là-haut ! 🦒";
    } else if (height >= 185) {
      return "Parfait pour le basket ! 🏀";
    } else if (height >= 180) {
      return "Belle taille ! 📏";
    } else if (height >= 175) {
      return "Dans la moyenne haute ! 👌";
    } else if (height >= 170) {
      return "Taille idéale ! ✨";
    } else if (height >= 165) {
      return "Parfaitement proportionné ! 💫";
    } else if (height >= 160) {
      return "Taille dynamique ! 💪";
    } else if (height >= 150) {
      return "Petit mais costaud ! 🔥";
    } else {
      return "La taille parfaite pour toi ! ⭐";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quelle est ta taille ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Obx(() => Column(
              children: [
                Text(
                  '${controller.height.value.toInt()} cm',
                  style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'Oscine',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7E1D),
                  ),
                ),
                const SizedBox(height: 10),
                // Nouveau texte pour le commentaire personnalisé
                AnimatedSwitcher(
                  key: Key(controller.height.value.toString()),
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    getHeightComment(controller.height.value),
                    key: ValueKey(controller.height.value.toInt()),
                    style: const TextStyle(
                      fontFamily: 'Oscine',
                      fontSize: 16,
                      color: Color(0xFFFF7E1D),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            )),
        const SizedBox(height: 20),
        Obx(() => SliderTheme(
              data: SliderThemeData(
                activeTrackColor: const Color(0xFFFF7E1D),
                inactiveTrackColor: const Color(0xFFFF7E1D).withOpacity(0.2),
                thumbColor: const Color(0xFFFF7E1D),
                overlayColor: const Color(0xFFFF7E1D).withOpacity(0.2),
                trackHeight: 8,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              ),
              child: Slider(
                value: controller.height.value,
                min: 140,
                max: 220,
                divisions: 80,
                onChanged: (value) => controller.updateHeight(value),
              ),
            )),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('140 cm', style: TextStyle(color: Colors.grey)),
            Text('220 cm', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}

class WeightInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const WeightInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Quel est ton poids ?',
            style: TextStyle(
              fontFamily: 'Oscine',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xFFFF7E1D),
                iconSize: 32,
                onPressed: () {
                  if (controller.weight.value > 40) {
                    controller.updateWeight(controller.weight.value - 0.5);
                  }
                },
              ),
              const SizedBox(width: 20),
              Obx(() => Text(
                    '${controller.weight.value.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: 'Oscine',
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFFFF7E1D),
                iconSize: 32,
                onPressed: () {
                  if (controller.weight.value < 150) {
                    controller.updateWeight(controller.weight.value + 0.5);
                  }
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        // Affichage du BMR si disponible
        Obx(() {
          if (controller.basalMetabolicRate.value > 0) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8F3),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: const Color(0xFFFF7E1D).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Votre métabolisme de base',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Oscine',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${controller.basalMetabolicRate.value.toStringAsFixed(0)} calories',
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: 'Oscine',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF7E1D),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}

class RestrictionsInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const RestrictionsInputContent({super.key, required this.controller});

  List<RestrictionsType> _getSortedRestrictions() {
    // Créer une nouvelle liste avec "aucune" en premier
    var list = List<RestrictionsType>.from(RestrictionsType.values);
    list.remove(RestrictionsType.aucune);
    return [RestrictionsType.aucune, ...list];
  }

  @override
  Widget build(BuildContext context) {
    final sortedRestrictions = _getSortedRestrictions();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'As-tu des restrictions alimentaires ?',
          style: TextStyle(
            fontFamily: 'Oscine',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemCount: sortedRestrictions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final restriction = sortedRestrictions[index];
              return Obx(() => GestureDetector(
                    onTap: () => controller.updateUserRestrictions(restriction),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.restrictions.value == restriction
                              ? const Color(0xFFFF7E1D)
                              : Colors.grey.withOpacity(0.3),
                          width: 2,
                        ),
                        color: controller.restrictions.value == restriction
                            ? const Color(0xFFFFF8F3)
                            : Colors.white,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8F3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              _getIconForRestriction(restriction),
                              color: const Color(0xFFFF7E1D),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restriction.toDbValue(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Oscine',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getDescriptionForRestriction(restriction),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Oscine',
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (controller.restrictions.value == restriction)
                            const Icon(
                              Icons.check_circle,
                              color: Color(0xFFFF7E1D),
                            ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }

  IconData _getIconForRestriction(RestrictionsType restriction) {
    switch (restriction) {
      case RestrictionsType.aucune:
        return Icons.clear_all;
      case RestrictionsType.vegetarien:
        return Icons.eco;
      case RestrictionsType.vegetalien:
        return Icons.spa;
      case RestrictionsType.sansGluten:
        return Icons.no_food;
      case RestrictionsType.sansSucre:
        return Icons.no_drinks;
      case RestrictionsType.halal:
        return Icons.check_circle;
    }
  }

  String _getDescriptionForRestriction(RestrictionsType restriction) {
    switch (restriction) {
      case RestrictionsType.aucune:
        return 'Pas de restriction particulière';
      case RestrictionsType.vegetarien:
        return 'Pas de viande ni de poisson';
      case RestrictionsType.vegetalien:
        return 'Aucun produit d\'origine animale';
      case RestrictionsType.sansGluten:
        return 'Exclusion de tout aliment contenant du gluten';
      case RestrictionsType.sansSucre:
        return 'Limitation des sucres ajoutés';
      case RestrictionsType.halal:
        return 'Alimentation conforme aux préceptes islamiques';
    }
  }
  // ... reste du code inchangé (méthodes _getIconForRestriction et _getDescriptionForRestriction) ...
}

class DeadlineInputContent extends StatelessWidget {
  final SecondOnboardingController controller;

  const DeadlineInputContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('fr_FR', null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fixe-toi un objectif dans le temps ! 🎯',
          style: TextStyle(
            fontFamily: 'Oscine',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/mascotteconnexion.png',
              height: 90,
              width: 90,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  border: Border.all(
                    color: const Color(0xFFFF7E1D).withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Petit triangle pour l'effet bulle
                    Transform.translate(
                      offset: const Offset(-24, 10),
                      child: CustomPaint(
                        size: const Size(12, 12),
                        painter: BubbleTrianglePainter(
                            const Color(0xFFFF7E1D).withOpacity(0.3)),
                      ),
                    ),
                    Text(
                      'Plus tu te fixes une date proche, plus la restriction alimentaire sera importante mais tu vas le faire !',
                      style: TextStyle(
                        fontFamily: 'Oscine',
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            children: [
              _buildQuickDateOption(
                context,
                '1 mois',
                DateTime.now().add(const Duration(days: 30)),
                '💪 Sprint intense',
              ),
              const SizedBox(height: 12),
              _buildQuickDateOption(
                context,
                '3 mois',
                DateTime.now().add(const Duration(days: 90)),
                '🌟 Transformation visible',
              ),
              const SizedBox(height: 12),
              _buildQuickDateOption(
                context,
                '6 mois',
                DateTime.now().add(const Duration(days: 180)),
                '🏆 Changement durable',
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Ou choisis ta propre date',
                  style: TextStyle(
                    fontFamily: 'Oscine',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFF7E1D).withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8F3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Color(0xFFFF7E1D),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Une compétition à préparer ?',
                          style: TextStyle(
                            fontFamily: 'Oscine',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Obx(() => CupertinoSwitch(
                          value: controller.competition.value,
                          activeColor: const Color(0xFFFF7E1D),
                          onChanged: (value) {
                            controller.competition.value = value;
                            if (value) {
                              _showMotivationDialog(context);
                            }
                            controller.updateCompetition(value);
                          },
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildCustomDatePicker(context),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showMotivationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFF7E1D).withOpacity(0.3),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8F3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Color(0xFFFF7E1D),
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Champion en devenir ! 🏆",
                  style: TextStyle(
                    fontFamily: 'Oscine',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7E1D),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "La compétition demande une préparation spéciale. On va t'aider à atteindre ton meilleur niveau !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Oscine',
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: "Je suis prêt !",
                  onPressed: () => Navigator.pop(context),
                  fullWidth: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickDateOption(
      BuildContext context, String label, DateTime date, String motivation) {
    return Obx(() => GestureDetector(
          onTap: () => controller.updateDeadline(date),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: controller.deadline.value?.day == date.day
                    ? const Color(0xFFFF7E1D)
                    : Colors.grey.withOpacity(0.3),
                width: 2,
              ),
              color: controller.deadline.value?.day == date.day
                  ? const Color(0xFFFFF8F3)
                  : Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8F3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Oscine',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF7E1D),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMMM yyyy', 'fr_FR').format(date),
                        style: const TextStyle(
                          fontFamily: 'Oscine',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        motivation,
                        style: TextStyle(
                          fontFamily: 'Oscine',
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildCustomDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 30)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFFFF7E1D),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          controller.updateDeadline(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF7E1D), Color(0xFFFFAA77)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF7E1D).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date personnalisée',
                        style: TextStyle(
                          fontFamily: 'Oscine',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Choisis ta propre date objectif',
                        style: TextStyle(
                          fontFamily: 'Oscine',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => Text(
                    controller.deadline.value != null
                        ? 'Date sélectionnée : ${DateFormat('d MMMM yyyy', 'fr_FR').format(controller.deadline.value!)}'
                        : 'Aucune date sélectionnée',
                    style: const TextStyle(
                      fontFamily: 'Oscine',
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class BubbleTrianglePainter extends CustomPainter {
  final Color color;

  BubbleTrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
