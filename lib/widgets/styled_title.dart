import 'package:flutter/material.dart';

/// A custom widget that displays a styled title for the Pokémon app.
class StyledTitle extends StatelessWidget {
  final String text;

  const StyledTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Pokemon', // Use a custom Pokémon-like font if available
        fontSize: 24,
        color: const Color(0xFFFFCB05), // Pokémon Yellow
        letterSpacing: 2.0,
        shadows: [
          // Outer dark blue stroke effect
          Shadow(
            offset: const Offset(3.0, 3.0),
            blurRadius: 0.0,
            color: const Color(0xFF3C5AA6), // Pokémon Dark Blue
          ),
          Shadow(
            offset: const Offset(-3.0, -3.0),
            blurRadius: 0.0,
            color: const Color(0xFF3C5AA6), // Pokémon Dark Blue
          ),
          // Extra layer of depth
          Shadow(
            offset: const Offset(1.5, 1.5),
            blurRadius: 0.0,
            color: Colors.black.withAlpha(128),
          ),
        ],
      ),
    );
  }
}