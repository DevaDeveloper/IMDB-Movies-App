import 'package:hive/hive.dart';
import 'package:imdb_movies_app/consts/hive/hive_consts.dart';
import 'package:imdb_movies_app/features/movies/helper/hive/hive_helper.dart';
import 'package:imdb_movies_app/features/movies/models/hive/movies.dart' as hiveMovies;
import 'package:imdb_movies_app/features/movies/models/hive/results.dart' as hiveResults;
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';

class HiveService {
  static Box<hiveMovies.Movies> handleGetHiveBox() {
    Box<hiveMovies.Movies> moviesBox = Hive.box<hiveMovies.Movies>(HiveConsts.moviesBoxFavourite);

    return moviesBox;
  }

  static hiveMovies.Movies? handleGetFavouriteMoviesFromHiveByKey(Box<hiveMovies.Movies> moviesBox) {
    hiveMovies.Movies? favouriteMovies = moviesBox.get(HiveConsts.favouriteMoviesKey);

    return favouriteMovies;
  }

  static hiveMovies.Movies? handleGetPopularMoviesFromHiveByKey(Box<hiveMovies.Movies> moviesBox) {
    hiveMovies.Movies? popularMovies = moviesBox.get(HiveConsts.popularMoviesKey);

    return popularMovies;
  }

  static void handleCachePopularMovies(List<Results> popularMoviesWithGenreNames, int page, List<Results> results) {
    Box<hiveMovies.Movies> moviesBox = HiveService.handleGetHiveBox();
    hiveMovies.Movies? popularMoviesHive = HiveService.handleGetPopularMoviesFromHiveByKey(moviesBox);
    List<hiveResults.Results> cachedPopularMovies = [...popularMoviesHive?.popularMovies ?? []];

    List<hiveResults.Results> mappedMovies = HiveHelper.handleMappingPopularMoviesToCacheDataModel(popularMoviesWithGenreNames);

    int resultsNumber = page * results.length;
    int cachedMoviesNumber = popularMoviesHive?.popularMovies?.length ?? 0;

    if (resultsNumber > cachedMoviesNumber) {
      cachedPopularMovies.addAll(mappedMovies);

      moviesBox.put(HiveConsts.popularMoviesKey, hiveMovies.Movies(popularMovies: cachedPopularMovies));
    }
  }
}
