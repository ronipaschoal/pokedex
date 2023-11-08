import 'package:graphql/client.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/repositories/i_pokemon_repository.dart';

class PokemonGraphqlRepository implements IPokemonRepository {
  static const _url = 'https://beta.pokeapi.co/graphql/v1beta';

  final GraphQLClient _client = GraphQLClient(
    link: HttpLink(_url),
    cache: GraphQLCache(),
  );

  @override
  Future<List<PokemonModel>> getPokemons({int page = 0}) async {
    try {
      const String query = r'''
        query pokemonListQuery($offset: Int!) {
          pokemons: pokemon_v2_pokemon(offset: $offset, limit: 20, order_by: {id: asc}) {
            id
            name
            types: pokemon_v2_pokemontypes {
              type: pokemon_v2_type {
                name
              }
            }
          }
        }
      ''';

      final QueryResult response = await _client.query(QueryOptions(
        document: gql(query),
        variables: {'offset': (page - 1) * 20},
      ));

      if (response.data == null) return <PokemonModel>[];

      final data = response.data as Map<String, dynamic>;
      final pokemonList = data['pokemons'] as List<dynamic>;

      if (pokemonList.isEmpty) return <PokemonModel>[];

      return pokemonList.map(
        (pokemon) {
          final id = pokemon['id'] as int;
          return PokemonModel(
            id: id,
            name: pokemon['name'] ?? '',
            image: IPokemonRepository.getImageById(id),
            types: (pokemon['types'] as List<dynamic>)
                .map((type) => type['type']['name'] as String)
                .toList(),
          );
        },
      ).toList();
    } catch (e) {
      return <PokemonModel>[];
    }
  }
}
