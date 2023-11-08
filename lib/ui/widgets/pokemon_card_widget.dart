import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex/helpers/pokemon_type_helper.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/ui/app_theme.dart';

class PokemonCardWidget extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonCardWidget({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          gradient: PokemonTypeHelper.getGradientByPokemon(pokemon),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 5.0),
              blurRadius: 1.0,
            ),
          ]),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            _handlePokemonImage,
            const SizedBox(height: 16.0),
            _handlePokemonName,
            const SizedBox(height: 16.0),
            _handlePokemonTypes,
          ],
        ),
      ),
    );
  }

  Widget get _handlePokemonImage {
    return SvgPicture.network(
      pokemon.image,
      height: 200.0,
      placeholderBuilder: (_) => const Padding(
        padding: EdgeInsets.all(32.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget get _handlePokemonName {
    return Text(
      '#${pokemon.id} ${pokemon.name}'.toUpperCase(),
      style: const TextStyle(
        fontSize: 24.0,
        fontFamily: 'PokemonGb',
      ),
    );
  }

  Widget get _handlePokemonTypes {
    final types = pokemon.types.map((type) => _handleTypeIcon(type)).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: types,
    );
  }

  Widget _handleTypeIcon(String type) {
    return SizedBox(
      height: 60,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset(
              'assets/images/poketypes/$type.png',
              color: AppTheme.itemTitle,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            type,
            style: TextStyle(color: AppTheme.itemTitle),
          ),
        ],
      ),
    );
  }
}
