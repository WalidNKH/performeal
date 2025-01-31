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
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
  }
}
