import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) {
          final date = DateTime.now().add(Duration(days: index - 2));
          final isSelected = index == 2; // Jour actuel

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: [
                // Conteneur blanc avec bordure
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(
                            color: const Color(0xFFEC661D),
                            // width: 1.5,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mars',
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFFEC661D)
                              : Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFFEC661D)
                              : Colors.black54,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Conteneur orange pour la date sélectionnée
                if (isSelected)
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEC661D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mars',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class MealTypeSelector extends StatelessWidget {
  const MealTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildMealType('Petit-Déjeuner', true),
          _buildMealType('Déjeuner', false),
          _buildMealType('Dinner', false),
        ],
      ),
    );
  }

  Widget _buildMealType(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFFEC661D) : Colors.black54,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int points;
  final String duration;
  final String imageUrl;
  final bool isAssetImage;

  const MealCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.duration,
    required this.imageUrl,
    this.isAssetImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isAssetImage
                  ? Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 12),
          // Contenu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$points points',
                  style: const TextStyle(
                    color: Color(0xFF6CB663),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(duration),
                  ],
                ),
              ],
            ),
          ),
          // Bouton
          IconButton(
            icon: const Icon(
              Icons.add_circle,
              color: Color(0xFFF6B12D),
              size: 32,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
