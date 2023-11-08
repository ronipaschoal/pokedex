import 'package:pokedex/models/pokemon_model.dart';

abstract class IPokemonRepository {
  Future<List<PokemonModel>> getPokemons({int page = 0});

  static String url = 'https://raw.githubusercontent.com';
  static String getImageById(int id) {
    return '$url/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg';
  }
}
