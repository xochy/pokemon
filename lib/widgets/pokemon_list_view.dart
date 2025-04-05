import 'package:flutter/material.dart';
import 'package:pokemon/widgets/pokemon_list_tile.dart';
import 'package:pokemon_package/pokemon_package.dart';

/// Creates a ListView widget to display the list of Pokemons.
/// It uses a ListView.builder to create a scrollable list of Pokemon items.
/// Each item in the list is represented by a ListTile widget.
class PokemonListView extends StatelessWidget {
  final PokemonLoaded state;
  final ScrollController scrollController;

  const PokemonListView({
    super.key,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: state.pokemons.length + (state.hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        // If the index is equal to the length of the list, it means we are at the end of the list.
        // In this case, we can show a loading indicator to indicate that more data is being loaded.
        if (index >= state.pokemons.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final pokemon = state.pokemons[index];
        return PokemonListTile(pokemon: pokemon);
      },
    );
  }
}
