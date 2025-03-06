import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:performeal/auth/auth_service.dart';
import 'package:performeal/routes.dart';

class ProfileHeader extends StatelessWidget {
  final AuthService authService;
  final String userName;

  const ProfileHeader({
    super.key,
    required this.authService,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Points container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFD700), size: 20),
                const SizedBox(width: 4),
                Text(
                  '150',
                  style: TextStyle(
                    fontFamily: 'Oscine',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salut $userName',
                  style: const TextStyle(
                    fontFamily: 'Oscine',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9DC41E),
                  ),
                ),
                const Text(
                  'Voici ton suivi quotidien',
                  style: TextStyle(
                    fontFamily: 'Oscine',
                    fontSize: 16,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressTrack extends StatelessWidget {
  final DateTime deadline;

  const ProgressTrack({
    super.key,
    required this.deadline,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final totalDays = deadline.difference(now).inDays;
    final progress = 1 - (totalDays / 365);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF8F3),
        ),
        child: Stack(
          children: [
            // Ligne de progression
            const Positioned.fill(
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            // Drapeau d'arrivée
            const Positioned(
              right: 20,
              top: 5,
              child: Icon(Icons.flag, color: Color(0xFFEC661D), size: 40),
            ),
            // Runner avec image personnalisée
            Positioned(
              left: MediaQuery.of(context).size.width * progress * 0.7,
              // top: 10,
              bottom: 3,
              child: Image.asset(
                'assets/images/course.png',
                height: 90, // Ajustez la taille selon vos besoins
                width: 90,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  const DottedLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFEC661D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashWidth = 10.0;
    final dashSpace = 5.0;
    double startX = 0;
    final path = Path();

    while (startX < size.width) {
      path.moveTo(startX, size.height / 2);
      path.lineTo(startX + dashWidth, size.height / 2);
      startX += dashWidth + dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
