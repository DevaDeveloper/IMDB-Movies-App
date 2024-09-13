import 'package:dio/dio.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';

class MoviesHelper {
  static GetGenreResponse parseJsonData(Response<dynamic>? response) {
    GetGenreResponse genres = GetGenreResponse.fromJson(response?.data);
    return genres;
  }
}
