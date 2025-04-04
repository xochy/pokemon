import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/bloc/pokemon_bloc.dart';
import 'package:pokemon/pages/pokemons_list_page.dart';
import 'package:pokemon/repositories/pokemon_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Who's That Pokémon?",
      initialRoute: 'list',
      routes: {
        'list': (context) => BlocProvider(
          create: (context) => PokemonBloc(PokemonRepository())..add(LoadPokemons()),
          child: const PokemonsListPage(),
        ),
        // Add other routes here
      },
    );
  }
}
