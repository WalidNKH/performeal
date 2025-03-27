import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFF8F3),
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7E1D).withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
              _buildNavItem(1, Icons.restaurant_menu_outlined,
                  Icons.restaurant_menu, 'Recettes'),
              _buildAddButton(),
              _buildNavItem(3, Icons.fitness_center_outlined,
                  Icons.fitness_center, 'Planning'),
              _buildNavItem(4, Icons.person_outline, Icons.person, 'Compte'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData outlinedIcon, IconData filledIcon, String label) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFFFF8F3)
                  : Colors.white.withOpacity(0),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected
                  ? const Color(0xFFFF7E1D)
                  : const Color(0xFF9E9E9E),
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFFFF7E1D)
                  : const Color(0xFF9E9E9E),
              fontSize: 12,
              fontFamily: 'Oscine',
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  'Ajouter un repas',
                  Icons.restaurant_menu,
                  () {
                    Get.back();
                    // Navigation vers l'ajout de repas
                  },
                ),
                const SizedBox(height: 15),
                _buildActionButton(
                  'Ajouter une activité',
                  Icons.fitness_center,
                  () {
                    Get.back();
                    // Navigation vers l'ajout d'activité
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF6B12D), Color(0xFFFFAA77)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF7E1D).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFFF7E1D).withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFFFF7E1D),
              size: 24,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFFF7E1D),
                fontSize: 16,
                fontFamily: 'Oscine',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
