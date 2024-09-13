import 'package:equatable/equatable.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';

class MoviesState extends Equatable {
  final List<Genres>? genres;
  final int? moviesPopularPage;
  final List<Results>? moviesPopularResults;
  final int? moviesPopularTotalPages;
  final int? moviesPopularTotalResults;

  const MoviesState({
    this.genres,
    this.moviesPopularPage,
    this.moviesPopularResults,
    this.moviesPopularTotalPages,
    this.moviesPopularTotalResults,
  });

  factory MoviesState.initial() {
    return const MoviesState(
      genres: [],
      moviesPopularPage: 1,
      moviesPopularResults: [],
      moviesPopularTotalPages: 1,
      moviesPopularTotalResults: 0,
    );
  }

  MoviesState copyWith({
    List<Genres>? genres,
    int? moviesPopularPage,
    List<Results>? moviesPopularResults,
    int? moviesPopularTotalPages,
    int? moviesPopularTotalResults,
  }) {
    return MoviesState(
      genres: genres ?? this.genres,
      moviesPopularPage: moviesPopularPage ?? this.moviesPopularPage,
      moviesPopularResults: moviesPopularResults ?? this.moviesPopularResults,
      moviesPopularTotalPages: moviesPopularTotalPages ?? this.moviesPopularTotalPages,
      moviesPopularTotalResults: moviesPopularTotalResults ?? this.moviesPopularTotalResults,
    );
  }

  @override
  List<Object?> get props => [
        genres,
        moviesPopularPage,
        moviesPopularResults,
        moviesPopularTotalPages,
        moviesPopularTotalResults,
      ];
}
