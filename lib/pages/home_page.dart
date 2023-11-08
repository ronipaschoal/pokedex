import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubits/pokemon/pokemon_cubit.dart';
import 'package:pokedex/ui/widgets/pokemon_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PokemonCubit>().load();
    _buildScrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: SizedBox(
        height: 40.0,
        child: Image.asset('assets/images/pokedex_logo.png'),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget get _body {
    return BlocBuilder<PokemonCubit, PokemonState>(
      builder: (context, state) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: state.list.length,
          itemBuilder: (_, index) {
            final pokemon = state.list[index];
            return PokemonCardWidget(
              pokemon: pokemon,
            );
          },
        );
      },
    );
  }

  void _buildScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<PokemonCubit>().load();
      }
    });
  }
}
