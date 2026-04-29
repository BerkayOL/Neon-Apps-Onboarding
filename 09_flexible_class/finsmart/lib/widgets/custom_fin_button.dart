import 'package:flutter/material.dart';

class CustomFinButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomFinButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle m3Style = FilledButton.styleFrom(
      backgroundColor: const Color(0xFF2E7D32),
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size(80, 52),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'Antonio',
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    );
    Widget buttonText = Text(
      text,
      maxLines: 1,
      overflow:
          TextOverflow.ellipsis, // Sığmazsa kelimeyi kesip sonuna "..." koyar
    );

    if (icon != null) {
      return FilledButton.icon(
        onPressed: onPressed,
        style: m3Style,
        icon: Icon(icon, size: 20),

        label: Flexible(child: buttonText),
      );
    }

    return FilledButton(
      onPressed: onPressed,
      style: m3Style,
      child: buttonText,
    );
  }
}
