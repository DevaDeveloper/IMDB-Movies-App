import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';

class MoviesHelper {
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
}
