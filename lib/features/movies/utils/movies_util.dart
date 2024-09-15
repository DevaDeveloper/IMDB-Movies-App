import 'package:collection/collection.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';

class MoviesUtil {
  static List<Results> handleSetGenreNamesToMovies(List<Results>? popularMovies, List<Genres>? genres) {
    if (MoviesHelper.isPopularMoviesEmpty(popularMovies)) {
      return [];
    }

    List<Results>? newPopularMovies = [...popularMovies!];

    newPopularMovies.forEach((movie) {
      List<String>? genreNames = handleFindGenreNamesByGenreId(movie, genres);

      movie.genreNames?.addAll(genreNames);
    });

    return newPopularMovies;
  }

  static List<String> handleFindGenreNamesByGenreId(Results movie, List<Genres>? genres) {
    List<String>? genreNames = [];

    movie.genreIds?.forEach((genreId) {
      Genres? genre = genres?.firstWhereOrNull((singleGenre) => genreId == singleGenre.id);

      if (genre != null) {
        genreNames.add(genre.name ?? '');
      }
    });

    return genreNames;
  }
}
