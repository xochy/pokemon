import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pages/pokemons_list_page.dart';
import 'package:pokemon_package/pokemon_package.dart';
import 'package:pokemon_package/repositories/pokemon_repository.dart';

// Use your models and BLoC here

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the PokemonBloc and SinglePokemonBloc to the widget tree
    return MultiBlocProvider(
      providers: [
        // The PokemonBloc is responsible for managing the list of Pokémon.
        BlocProvider(
          create:
              (context) =>
                  PokemonBloc(PokemonRepository())
                    ..add(LoadPokemons(offset: 0, limit: 20)),
        ),
        // The SinglePokemonBloc is responsible for managing the details of a single Pokémon.
        BlocProvider(
          create: (context) => SinglePokemonBloc(PokemonRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Who's That Pokémon?",
        home: const PokemonsListPage(),
      ),
    );
  }
}
