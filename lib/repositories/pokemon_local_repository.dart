import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/i_pokemon_repository.dart';

// json-server --watch ./assets/data/pokemon_data.json --host 192.168.0.105
class PokemonLocalRepository implements IPokemonRepository {
  final Dio _http = Dio();

  @override
  Future<List<PokemonModel>> getPokemons({int page = 0}) async {
    try {
      final response = await _http
          .get('http://192.168.0.105:3000/pokemons?_page=$page&_limit=20');
      final pokemonList = response.data as List<dynamic>;

      if (pokemonList.isEmpty) return <PokemonModel>[];

      return pokemonList.map(
        (pokemon) {
          final id = pokemon['id'] as int;
          return PokemonModel(
            id: id,
            name: pokemon['name'] as String,
            image: IPokemonRepository.getImageById(id),
            types: (pokemon['type'] as List<String>),
          );
        },
      ).toList();
    } catch (e) {
      return <PokemonModel>[];
    }
  }
}
