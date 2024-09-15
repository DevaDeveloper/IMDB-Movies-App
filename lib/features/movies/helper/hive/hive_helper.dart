import 'package:imdb_movies_app/features/movies/models/hive/results.dart' as hiveResults;
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';

class HiveHelper {
  static hiveResults.Results createHiveMovieObject(Results movie) {
    hiveResults.Results newResultsObject = hiveResults.Results(
      id: movie.id,
      genreIds: movie.genreIds,
      genreNames: movie.genreNames,
      overview: movie.overview,
      originalTitle: movie.originalTitle,
      title: movie.title,
      posterPath: movie.posterPath,
      voteAverage: movie.voteAverage,
      popularity: movie.popularity,
      voteCount: movie.voteCount,
    );

    return newResultsObject;
  }

  static List<Results> handleMappingCacheData(List<hiveResults.Results> cacheFavouriteMovies) {
    List<Results> results = cacheFavouriteMovies
        .map((movie) => Results(
              id: movie.id,
              genreIds: movie.genreIds,
              genreNames: movie.genreNames,
              overview: movie.overview,
              originalTitle: movie.originalTitle,
              title: movie.title,
              posterPath: movie.posterPath,
              voteAverage: movie.voteAverage,
              popularity: movie.popularity,
              voteCount: movie.voteCount,
            ))
        .toList();

    return results;
  }
}
