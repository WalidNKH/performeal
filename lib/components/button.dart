import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle? style;
  final double? width; // Nouvelle propriété pour la largeur
  final bool fullWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor = const Color(0xFFEC661D),
    this.foregroundColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 2.0,
    this.style,
    this.width, // Largeur spécifique si nécessaire
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            FaIcon(
              icon,
              color: foregroundColor,
              size: 24,
            ),
            const SizedBox(width: 12),
          ],
          Text(
            text,
            style: style ??
                const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Oscine',
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    // Si une largeur spécifique est fournie, on enveloppe le bouton dans un SizedBox avec cette largeur
    if (width != null) {
      return SizedBox(
        width: width,
        child: button,
      );
    }
    return button;
  }
}
