import 'package:pokedex/pages/home_page.dart';

sealed class Routes {
  static const home = '/';

  static final instancies = {
    home: (context) => const HomePage(),
  };
}
