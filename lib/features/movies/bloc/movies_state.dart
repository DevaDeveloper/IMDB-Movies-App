import 'package:equatable/equatable.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/movie_details.response.dart' as movieDetailsResponse;
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';

class MoviesState extends Equatable {
  final List<Genres>? genres;
  final int? moviesPopularPage;
  final List<Results>? moviesPopularResults;
  final int? moviesPopularTotalPages;
  final int? moviesPopularTotalResults;
  final movieDetailsResponse.MovieDetailsResponse? movieDetails;
  final List<Results>? favouriteMovies;
  final List<Results>? cachedPopularMovies;

  const MoviesState({
    this.genres,
    this.moviesPopularPage,
    this.moviesPopularResults,
    this.moviesPopularTotalPages,
    this.moviesPopularTotalResults,
    this.movieDetails,
    this.favouriteMovies,
    this.cachedPopularMovies,
  });

  factory MoviesState.initial() {
    return const MoviesState(
      genres: [],
      moviesPopularPage: 1,
      moviesPopularResults: [],
      moviesPopularTotalPages: 1,
      moviesPopularTotalResults: 0,
      movieDetails: null,
      favouriteMovies: [],
      cachedPopularMovies: [],
    );
  }

  MoviesState copyWith({
    List<Genres>? genres,
    int? moviesPopularPage,
    List<Results>? moviesPopularResults,
    int? moviesPopularTotalPages,
    int? moviesPopularTotalResults,
    movieDetailsResponse.MovieDetailsResponse? movieDetails,
    List<Results>? favouriteMovies,
    List<Results>? cachedPopularMovies,
  }) {
    return MoviesState(
      genres: genres ?? this.genres,
      moviesPopularPage: moviesPopularPage ?? this.moviesPopularPage,
      moviesPopularResults: moviesPopularResults ?? this.moviesPopularResults,
      moviesPopularTotalPages: moviesPopularTotalPages ?? this.moviesPopularTotalPages,
      moviesPopularTotalResults: moviesPopularTotalResults ?? this.moviesPopularTotalResults,
      movieDetails: movieDetails ?? this.movieDetails,
      favouriteMovies: favouriteMovies ?? this.favouriteMovies,
      cachedPopularMovies: cachedPopularMovies ?? this.cachedPopularMovies,
    );
  }

  @override
  List<Object?> get props => [
        genres,
        moviesPopularPage,
        moviesPopularResults,
        moviesPopularTotalPages,
        moviesPopularTotalResults,
        movieDetails,
        favouriteMovies,
        cachedPopularMovies,
      ];
}
