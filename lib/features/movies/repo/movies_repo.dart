import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imdb_movies_app/consts/api/api_path.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/movie_details.response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/models/failure_model.dart';
import 'package:imdb_movies_app/models/response.dart';
import 'package:imdb_movies_app/utils/exceptions/repo_exception.dart';
import 'package:imdb_movies_app/utils/services/rest_api/api_service.dart';

class MoviesRepository {
  ApiService apiService = ApiService();

  Future<ResponseApp<GetGenreResponse>> getMovieGenres() async {
    try {
      Response? response = await apiService.getHTTP(ApiPath.GENRE, null);

      if (response?.statusCode == 204) {
        return ResponseApp(failure: noContentError);
      }

      GetGenreResponse genres = MoviesHelper.parseJsonDataGenres(response);

      return ResponseApp(data: genres);
    } on RepoException catch (e) {
      debugPrint('e getMovieGenres: $e');
      return ResponseApp(failure: e.failure);
    } catch (ex) {
      debugPrint('ex getMovieGenres: $ex');
      return ResponseApp(failure: parsingError);
    }
  }

  Future<ResponseApp<GetMoviesPopularResponse>> getMoviesPopular(int pageNumber) async {
    try {
      Map<String, dynamic>? queryParams = {'language': 'en', 'page': pageNumber};

      Response? response = await apiService.getHTTP(ApiPath.MOVIES_POPULAR, queryParams);

      if (response?.statusCode == 204) {
        return ResponseApp(failure: noContentError);
      }

      GetMoviesPopularResponse genres = MoviesHelper.parseJsonDataPopularMovies(response);

      return ResponseApp(data: genres);
    } on RepoException catch (e) {
      debugPrint('e getMoviesPopular: $e');
      return ResponseApp(failure: e.failure);
    } catch (ex) {
      debugPrint('ex getMoviesPopular: $ex');
      return ResponseApp(failure: parsingError);
    }
  }

  Future<ResponseApp<MovieDetailsResponse>> getMovieDetails(String movieId) async {
    try {
      String apiPath = MoviesHelper.handleCreateMovieDetailsApiPath(movieId);

      Map<String, dynamic>? queryParams = {'language': 'en_US'};

      Response? response = await apiService.getHTTP(apiPath, queryParams);

      if (response?.statusCode == 204) {
        return ResponseApp(failure: noContentError);
      }

      MovieDetailsResponse movieDetails = MoviesHelper.parseJsonDataMovieDetails(response);

      return ResponseApp(data: movieDetails);
    } on RepoException catch (e) {
      debugPrint('e getMovieDetails: $e');
      return ResponseApp(failure: e.failure);
    } catch (ex) {
      debugPrint('ex getMovieDetails: $ex');
      return ResponseApp(failure: parsingError);
    }
  }
}
