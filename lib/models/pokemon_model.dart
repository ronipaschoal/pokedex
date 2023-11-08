// ignore_for_file: public_member_api_docs, sort_constructors_first
class PokemonModel {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  PokemonModel({
    required this.id,
    required this.name,
    required this.image,
    required this.types,
  });
}
