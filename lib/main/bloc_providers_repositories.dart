import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_movies_app/features/core/auth/bloc/auth_cubit.dart';
import 'package:imdb_movies_app/features/core/auth/repository/auth_repository.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/repo/movies_repo.dart';

class BlocProvidersRepositories extends StatelessWidget {
  final Widget child;
  final String languageCode;
  final String theme;
  final String? token;
  final String? userId;

  const BlocProvidersRepositories({
    super.key,
    required this.child,
    required this.languageCode,
    required this.theme,
    required this.token,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepository()),
        RepositoryProvider<MoviesRepository>(create: (context) => MoviesRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              token: token,
              userId: userId,
            ),
          ),
          BlocProvider<MoviesCubit>(
            create: (context) => MoviesCubit(),
          ),
        ],
        child: child,
      ),
    );
  }
}
