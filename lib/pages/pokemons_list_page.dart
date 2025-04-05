import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/widgets/pokemon_details_dialog.dart';
import 'package:pokemon/widgets/pokemon_list_view.dart';
import 'package:pokemon/widgets/styled_title.dart';
import 'package:pokemon_package/pokemon_package.dart';

/// This widget represents the main page of the Pokémon app.
/// It displays a list of Pokémon and allows the user to search for specific Pokémon by name.
/// It uses the Bloc pattern to manage the state of the Pokémon list and the details of a single Pokémon.
/// The page includes a search bar and a list of Pokémon, which can be scrolled to load more Pokémon.
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
        title: const StyledTitle(text: "Who's That Pokémon?"),
        backgroundColor: const Color.fromARGB(255, 202, 76, 76),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchModal(context),
          ),
        ],
      ),
      // The BlocListener widget listens for state changes in the SinglePokemonBloc.
      // When a new state is emitted, it triggers the listener function.
      body: BlocListener<SinglePokemonBloc, SinglePokemonState>(
        listener: (context, state) {
          if (state is SinglePokemonLoaded) {
            showPokemonDetailsDialog(context, state.pokemon);
          } else if (state is SinglePokemonError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        // The BlocBuilder widget rebuilds the UI based on the current state of the PokemonBloc.
        // It listens for state changes and rebuilds the widget tree accordingly.
        child: _blocBuilder(),
      ),
    );
  }

  // Shows a modal bottom sheet for searching Pokemons by name.
  // The modal contains a TextField for input and a button to trigger the search.
  // When the button is pressed, it dispatches an event to load the Pokemon with the given name.
  // After the search, it closes the modal.
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

  // Builds the BlocBuilder widget to manage the state of the Pokemon list.
  // It listens for state changes and rebuilds the UI accordingly.
  // Depending on the state, it shows a loading indicator, the list of Pokemons,
  BlocBuilder<PokemonBloc, PokemonState> _blocBuilder() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoading && state is PokemonInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoaded) {
          return PokemonListView(
            state: state,
            scrollController: _scrollController,
          ); // Use the new widget
        } else if (state is PokemonError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Loading Pokemons...'));
        }
      },
    );
  }
}
