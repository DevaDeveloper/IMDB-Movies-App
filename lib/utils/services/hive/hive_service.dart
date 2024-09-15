import 'package:hive/hive.dart';
import 'package:imdb_movies_app/consts/hive/hive_consts.dart';
import 'package:imdb_movies_app/features/movies/models/hive/movies.dart';

class HiveService {
  static Box<Movies> handleGetFavouriteHiveBox() {
    Box<Movies> moviesBox = Hive.box<Movies>(HiveConsts.moviesBoxFavourite);

    return moviesBox;
  }

  static Movies? handleGetFavouriteMoviesFromHiveByKey(Box<Movies> moviesBox) {
    Movies? favouriteMovies = moviesBox.get(HiveConsts.favouriteMoviesKey);

    return favouriteMovies;
  }
}
