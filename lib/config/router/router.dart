import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_movies_app/config/router/router_paths.dart';
import 'package:imdb_movies_app/features/movies/views/favourites/favourites_screen.dart';
import 'package:imdb_movies_app/features/movies/views/movie_details/movie_details.dart';
import 'package:imdb_movies_app/features/movies/views/popular_movies/movies_screen.dart';

final List<GoRoute> appRoutes = [
  GoRoute(
    path: RouterPaths.homeScreen,
    name: RouterPages.homeScreen,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: const MoviesScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)),
          ),
          child: child,
        );
      },
    ),
  ),
  GoRoute(
    path: RouterPaths.favourites,
    name: RouterPages.favourites,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: const FavouritesScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)),
          ),
          child: child,
        );
      },
    ),
  ),
  GoRoute(
    path: RouterPaths.movieDetails,
    name: RouterPages.movieDetails,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: const MovieDetails(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)),
          ),
          child: child,
        );
      },
    ),
  ),
];
