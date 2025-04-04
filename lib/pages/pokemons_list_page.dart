import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/pokemons/pokemon_bloc.dart';
import 'package:pokemon/bloc/pokemon/single_pokemon_bloc.dart';
import 'package:pokemon/models/pokemon.dart';

class PokemonsListPage extends StatefulWidget {
  const PokemonsListPage({super.key});

  @override
  State<PokemonsListPage> createState() => _PokemonsListPageState();
}

// The _PokemonsListPageState class is responsible for managing the state of the PokemonsListPage widget.
class _PokemonsListPageState extends State<PokemonsListPage> {
  final _scrollController = ScrollController();
  int _offset = 0;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _offset += _limit;
      context.read<PokemonBloc>().add(
        LoadPokemons(offset: _offset, limit: _limit),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who's That Pokémon?"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchModal(context),
          ),
        ],
      ),
      body: BlocListener<SinglePokemonBloc, SinglePokemonState>(
        listener: (context, state) {
          if (state is SinglePokemonLoaded) {
            _showPokemonDetailsDialog(context, state.pokemon);
          } else if (state is SinglePokemonError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: _blocBuilder(),
      ),
    );
  }

  void _showSearchModal(BuildContext context) {
    final searchController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext modalContext) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: searchController,
                decoration: const InputDecoration(labelText: 'Pokemon Name'),
                onSubmitted: (value) {
                  context.read<SinglePokemonBloc>().add(
                    LoadSinglePokemon(name: value),
                  );
                  Navigator.pop(modalContext);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  context.read<SinglePokemonBloc>().add(
                    LoadSinglePokemon(name: searchController.text),
                  );
                  Navigator.pop(modalContext);
                },
                child: const Text('Search'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPokemonDetailsDialog(BuildContext context, Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pokemon.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pokemon.imageUrl != null)
                Image.network(pokemon.imageUrl!)
              else
                const SizedBox.shrink(),
              const SizedBox(height: 16),
              Text('ID: ${pokemon.id ?? "Unknown"}'),
              Text('Height: ${pokemon.height ?? "Unknown"}'),
              Text('Weight: ${pokemon.weight ?? "Unknown"}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Builds the BlocBuilder widget to manage the state of the Pokemon list.
  BlocBuilder<PokemonBloc, PokemonState> _blocBuilder() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading && state is PokemonInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoaded) {
          return _pokemonsList(state);
        } else if (state is PokemonError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Loading Pokemons...'));
        }
      },
    );
  }

  // Creates a ListView widget to display the list of Pokemons.
  ListView _pokemonsList(PokemonLoaded state) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: state.pokemons.length + (state.hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index >= state.pokemons.length) {
          return Center(child: CircularProgressIndicator());
        }
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
      onTap: () {
        context.read<SinglePokemonBloc>().add(
          LoadSinglePokemon(name: pokemon.name),
        );
      },
    );
  }
}
