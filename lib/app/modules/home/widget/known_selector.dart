import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';

class AnswerToggleButton extends StatelessWidget {
  const AnswerToggleButton({
    super.key,
    required this.controller,
    required this.text,
    required this.isActive,
    required this.onPressed,
  });

  final HomeController controller;
  final String text;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isActive
                    ? [
                      const Color(0xFF4CAF50).withAlpha(200),
                      const Color(0xFF2E7D32).withAlpha(200),
                    ] // Green gradient for active
                    : [
                      const Color(0xFFE0E0E0).withAlpha(200),
                      const Color(0xFFBDBDBD).withAlpha(200),
                    ], // Gray gradient for inactive
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color:
                  isActive
                      ? const Color(0xFF4CAF50).withAlpha(80)
                      : Colors.grey.withAlpha(80),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF757575),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
