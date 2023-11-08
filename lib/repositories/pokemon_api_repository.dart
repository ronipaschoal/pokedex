import 'package:dio/dio.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/i_pokemon_repository.dart';

class PokemonApiRepository implements IPokemonRepository {
  final _http = Dio();

  @override
  Future<List<PokemonModel>> getPokemons({int page = 0}) async {
    try {
      const url = 'https://pokeapi.co/api/v2/pokemon';
      final response = await _http //
          .get('$url?offset=${(page - 1) * 20}&limit=20');

      final data = response.data as Map<String, dynamic>;
      final pokemonList = data['results'] as List;

      if (pokemonList.isEmpty) return <PokemonModel>[];

      return pokemonList.map((pokemon) {
        final id = _getIdByUrl(pokemon['url'] as String);

        return PokemonModel(
          id: id,
          name: pokemon['name'] ?? '',
          image: IPokemonRepository.getImageById(id),
          types: <String>[],
        );
      }).toList();
    } catch (e) {
      return <PokemonModel>[];
    }
  }

  int _getIdByUrl(String url) {
    final String preId = url.split('pokemon')[1];
    return int.tryParse(preId.substring(1, preId.length - 1)) ?? 0;
  }
}
