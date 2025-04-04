import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/bloc/pokemon_bloc.dart';
import 'package:pokemon/models/pokemon.dart';

class PokemonsListPage extends StatefulWidget {
  const PokemonsListPage({super.key});

  @override
  State<PokemonsListPage> createState() => _PokemonsListPageState();
}

// The _PokemonsListPageState class is responsible for managing the state of the PokemonsListPage widget.
class _PokemonsListPageState extends State<PokemonsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Who's That Pokémon?")),
      body: _blocBuilder(),
    );
  }

  // Builds the BlocBuilder widget to manage the state of the Pokemon list.
  BlocBuilder<PokemonBloc, PokemonState> _blocBuilder() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoaded) {
          return _pokemonsList(state);
        } else if (state is PokemonError) {
          return Text(state.message);
        }
        return const Text("Something went wrong!");
      },
    );
  }

  // Creates a ListView widget to display the list of Pokemons.
  ListView _pokemonsList(PokemonLoaded state) {
    return ListView.builder(
      itemCount: state.pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = state.pokemons[index];
        return _pokemon(pokemon);
      },
    );
  }

  // Creates a ListTile widget for displaying a Pokemon's name and avatar.
  ListTile _pokemon(Pokemon pokemon) {
    return ListTile(
      title: Text(pokemon.name),
      leading: CircleAvatar(child: Text(pokemon.name.substring(0, 2))),
    );
  }
}
