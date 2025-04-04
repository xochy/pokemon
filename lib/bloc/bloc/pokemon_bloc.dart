import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/repositories/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

// PokemonBloc is responsible for managing the state of the Pokemon list
// and handling events related to fetching Pokemon data.
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;

  // Constructor for PokemonBloc, initializes the state to PokemonInitial
  PokemonBloc(this.pokemonRepository) : super(PokemonInitial()) {
    on<LoadPokemons>((event, emit) async {
      emit(PokemonLoading());
      try {
        final pokemons = await pokemonRepository.fetchPokemons();
        emit(PokemonLoaded(pokemons: pokemons));
      } catch (e) {
        emit(PokemonError(message: e.toString()));
      }
    });
  }
}
