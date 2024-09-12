import 'package:go_router/go_router.dart';
import 'package:imdb_movies_app/config/router/router_paths.dart';
import 'package:imdb_movies_app/features/movies/movies_screen.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: RouterPaths.homeScreen,
    name: RouterPages.homeScreen,
    builder: (context, state) => const MoviesScreen(),
    routes: const [],
  ),
];
