import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imdb_movies_app/consts/api/api_path.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/hive/results.dart' as hiveResults;
import 'package:imdb_movies_app/features/movies/models/movie_details.response.dart' as movieDetailsResponse;
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/models/response.dart';

class MoviesHelper {
  static bool checkIfMovieIsInCacheFavourites(List<hiveResults.Results>? favouriteMoviesState, int? movieId) {
    hiveResults.Results? favouriteMovie = favouriteMoviesState?.firstWhereOrNull((movie) => movie.id == movieId);

    if (favouriteMovie == null) {
      return false;
    }

    return true;
  }

  static GetGenreResponse parseJsonDataGenres(Response<dynamic>? response) {
    GetGenreResponse genres = GetGenreResponse.fromJson(response?.data);

    return genres;
  }

  static GetMoviesPopularResponse parseJsonDataPopularMovies(Response<dynamic>? response) {
    GetMoviesPopularResponse popularMovies = GetMoviesPopularResponse.fromJson(response?.data);

    return popularMovies;
  }

  static bool isFetchMorePopularMoviesValid(
      ScrollNotification scrollNotification, bool isLoadingMore, int totalPages, int currentPage) {
    return scrollNotification.metrics.pixels + 300 >= scrollNotification.metrics.maxScrollExtent * 0.95 &&
        !isLoadingMore &&
        currentPage <= totalPages;
  }

  static List<Results> getPopularMoviesState(MoviesState state) {
    List<Results> popularMoviesResults = [...state.moviesPopularResults ?? []];

    return popularMoviesResults;
  }

  static bool isGenresInState(List<Genres>? genreListState) => genreListState != null && genreListState.isNotEmpty;

  static int? handleGetPopularMoviesLength(List<Results>? moviesPopularResults) {
    int? moviesPopularLength = moviesPopularResults?.length ?? 0;

    return moviesPopularLength;
  }

  static bool isPopularMoviesInState(int? moviesPopularLength) => moviesPopularLength != null && moviesPopularLength > 0;

  static bool isPopularMoviesEmpty(List<Results>? popularMovies) => popularMovies == null || popularMovies.isEmpty;

  static String handleCreateMovieDetailsApiPath(String movieId) {
    String apiPath = '${ApiPath.MOVIE_DETAILS}/$movieId';

    return apiPath;
  }

  static movieDetailsResponse.MovieDetailsResponse parseJsonDataMovieDetails(Response<dynamic>? response) {
    movieDetailsResponse.MovieDetailsResponse movieDetails = movieDetailsResponse.MovieDetailsResponse.fromJson(response?.data);

    return movieDetails;
  }

  static bool isErrorResponse(ResponseApp<movieDetailsResponse.MovieDetailsResponse> result) =>
      result.isError || result.data == null;

  static bool checkIfMovieIsInFavourites(List<Results>? favouriteMoviesState, int? movieId) {
    Results? favouriteMovie = favouriteMoviesState?.firstWhereOrNull((movie) => movie.id == movieId);

    if (favouriteMovie == null) {
      return false;
    }

    return true;
  }

  static hiveResults.Results? findMovieInCachedMovies(List<hiveResults.Results>? favouriteMoviesState, int? movieId) {
    hiveResults.Results? favouriteMovie = favouriteMoviesState?.firstWhereOrNull((movie) => movie.id == movieId);

    return favouriteMovie;
  }
}
