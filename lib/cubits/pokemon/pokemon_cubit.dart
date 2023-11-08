import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/i_pokemon_repository.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  final IPokemonRepository repository;

  PokemonCubit({required this.repository}) : super(PokemonState());

  void load() async {
    emit(state.copyWith(loading: true));

    final List<PokemonModel> response =
        await repository.getPokemons(page: state.page);

    emit(state.copyWith(
      loading: false,
      page: state.page + 1,
      list: [...state.list, ...response],
    ));
  }
}
