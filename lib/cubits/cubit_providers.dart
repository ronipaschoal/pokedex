import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubits/pokemon/pokemon_cubit.dart';
import 'package:pokedex/repositories/pokemon_api_repository.dart';
import 'package:pokedex/repositories/pokemon_graphql_repository.dart';
import 'package:pokedex/repositories/pokemon_local_repository.dart';

// For didatic purposes
// Only change the repository to test the API or GraphQL
final repositoryList = [
  PokemonApiRepository(),
  PokemonGraphqlRepository(),
  PokemonLocalRepository(),
];

class CubitProviders {
  static final List<BlocProvider> instancies = [
    BlocProvider<PokemonCubit>(
      create: (_) => PokemonCubit(repository: repositoryList[1]),
    ),
  ];
}
