import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_package/pokemon_package.dart';

/// Creates a ListTile widget for displaying a Pokemon's name and avatar.
/// The ListTile widget is a material design list item that can be tapped to trigger an action.
/// When tapped, it dispatches an event to load the details of the selected Pokemon.
class PokemonListTile extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonListTile({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        pokemon.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: const Color.fromARGB(255, 60, 90, 166),
        child: Text(
          pokemon.name.substring(0, 2),
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 203, 5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        // When the ListTile is tapped, it dispatches an event to load the details of the selected Pokemon.
        // The event is handled by the SinglePokemonBloc, which is responsible for managing the details of a single Pokemon.
        context.read<SinglePokemonBloc>().add(
          LoadSinglePokemon(name: pokemon.name),
        );
      },
    );
  }
}
