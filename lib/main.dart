import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/cubits/cubit_providers.dart';
import 'package:pokedex/routes.dart';
import 'package:pokedex/ui/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CubitProviders.instancies,
      child: MaterialApp(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
        routes: Routes.instancies,
        initialRoute: Routes.home,
      ),
    );
  }
}
