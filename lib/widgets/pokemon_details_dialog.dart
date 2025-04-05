import 'package:flutter/material.dart';
import 'package:pokemon_package/pokemon_package.dart';

/// Helper function for styled text
Widget infoText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white, // White text for better readability
      ),
    ),
  );
}

/// Function to show a dialog with Pokémon details
void showPokemonDetailsDialog(BuildContext context, Pokemon pokemon) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF3C5AA6), // Pokémon dark blue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        title: Text(
          pokemon.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFCB05), // Pokémon yellow
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pokemon.imageUrl != null)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3, // White border around image
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    pokemon.imageUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
            const SizedBox(height: 16),
            infoText('ID: ${pokemon.id ?? "Unknown"}'),
            infoText('Height: ${pokemon.height ?? "Unknown"}'),
            infoText('Weight: ${pokemon.weight ?? "Unknown"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFD32F2F), // Pokémon red
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.white, // White text for contrast
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}