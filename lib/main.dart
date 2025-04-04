import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/pokemons/pokemon_bloc.dart';
import 'package:pokemon/bloc/pokemon/single_pokemon_bloc.dart';
import 'package:pokemon/pages/pokemons_list_page.dart';
import 'package:pokemon/repositories/pokemon_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  PokemonBloc(PokemonRepository())
                    ..add(LoadPokemons(offset: 0, limit: 20)),
        ),
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
