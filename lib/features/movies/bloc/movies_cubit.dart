import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_movies_app/consts/hive/hive_consts.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/helper/hive/hive_helper.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/hive/movies.dart';
import 'package:imdb_movies_app/features/movies/models/hive/results.dart' as hiveResults;
import 'package:imdb_movies_app/features/movies/models/movie_details.response.dart' as movieDetailsResponse;
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/features/movies/repo/movies_repo.dart';
import 'package:imdb_movies_app/features/movies/utils/movies_util.dart';
import 'package:imdb_movies_app/models/response.dart';
import 'package:imdb_movies_app/utils/services/hive/hive_service.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesState.initial());

  MoviesRepository moviesRepository = MoviesRepository();

  void handleClearPopularMoviesState() {
    emit(state.copyWith(
      moviesPopularPage: 1,
      moviesPopularResults: [],
      moviesPopularTotalPages: 1,
      moviesPopularTotalResults: 0,
    ));
  }

  void handleSetSingleFavouriteMovie(Results movie) {
    List<Results>? favouriteMoviesState = [...state.favouriteMovies ?? []];

    Box<Movies> moviesBox = HiveService.handleGetHiveBox();
    Movies? favouriteMoviesHiveRead = HiveService.handleGetFavouriteMoviesFromHiveByKey(moviesBox);
    List<hiveResults.Results> cachedFavouriteMovies = [...favouriteMoviesHiveRead?.favouriteMovies ?? []];

    bool isInFavourites = MoviesHelper.checkIfMovieIsInFavourites(favouriteMoviesState, movie.id);
    bool isInCacheFavourites = MoviesHelper.checkIfMovieIsInCacheFavourites(cachedFavouriteMovies, movie.id);

    if (!isInFavourites) {
      favouriteMoviesState.add(movie);
    }

    if (isInFavourites) {
      favouriteMoviesState.remove(movie);
    }

    if (!isInCacheFavourites) {
      hiveResults.Results newResultsObject = HiveHelper.createHiveMovieObject(movie);

      cachedFavouriteMovies.add(newResultsObject);
    }

    if (isInCacheFavourites) {
      hiveResults.Results? cachedMovie = MoviesHelper.findMovieInCachedMovies(cachedFavouriteMovies, movie.id);

      if (cachedMovie != null) {
        cachedFavouriteMovies.remove(cachedMovie);
      }
    }

    moviesBox.put(HiveConsts.favouriteMoviesKey, Movies(favouriteMovies: cachedFavouriteMovies));

    emit(state.copyWith(favouriteMovies: favouriteMoviesState));
  }

  void handleSetMultipleFavouriteMovies(List<Results> movies) {
    List<Results>? favouriteMovies = [...state.favouriteMovies ?? []];

    favouriteMovies.addAll(movies);

    emit(state.copyWith(favouriteMovies: favouriteMovies));
  }

  void handleSetMultiplePopularMovies(List<Results> movies) {
    List<Results>? popularMovies = [...state.cachedPopularMovies ?? []];

    popularMovies.addAll(movies);

    emit(state.copyWith(cachedPopularMovies: popularMovies));
  }

  Future<bool> handleGetGenres() async {
    List<Genres>? genreListState = state.genres;

    if (MoviesHelper.isGenresInState(genreListState)) {
      return true;
    }

    ResponseApp<GetGenreResponse>? result = await moviesRepository.getMovieGenres();

    if (result.isError) {
      return false;
    }

    List<Genres>? genresList = result.data?.genres ?? [];

    emit(state.copyWith(genres: genresList));

    return true;
  }

  Future<bool> handleGetPopularMovies() async {
    int pageNumber = state.moviesPopularPage ?? 1;

    ResponseApp<GetMoviesPopularResponse>? result = await moviesRepository.getMoviesPopular(pageNumber);

    if (result.isError) {
      return false;
    }

    GetMoviesPopularResponse? popularMovies = result.data;
    List<Results>? results = popularMovies?.results ?? [];

    List<Genres>? genres = [...state.genres ?? []];

    List<Results> popularMoviesWithGenreNames = MoviesUtil.handleSetGenreNamesToMovies(results, genres);

    List<Results> popularMoviesResults = MoviesHelper.getPopularMoviesState(state);

    int page = popularMovies?.page ?? 1;
    int? totalPages = popularMovies?.totalPages;
    int? totalResults = popularMovies?.totalResults;

    popularMoviesResults.addAll(popularMoviesWithGenreNames);

    int nextPage = page + 1;

    print('page: $page, results: ${results.length}, totalPages: $totalPages, totalResults: $totalResults');

    HiveService.handleCachePopularMovies(popularMoviesWithGenreNames, page, results);

    emit(state.copyWith(
      moviesPopularPage: nextPage,
      moviesPopularResults: popularMoviesResults,
      moviesPopularTotalPages: totalPages,
      moviesPopularTotalResults: totalResults,
    ));

    return true;
  }

  Future<bool> handleGetMovieDetails(String movieId) async {
    ResponseApp<movieDetailsResponse.MovieDetailsResponse> result = await moviesRepository.getMovieDetails(movieId);

    if (MoviesHelper.isErrorResponse(result)) {
      return false;
    }

    movieDetailsResponse.MovieDetailsResponse movieDetails = result.data!;

    emit(state.copyWith(movieDetails: movieDetails));

    return true;
  }
}
