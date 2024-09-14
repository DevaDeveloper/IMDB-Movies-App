import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/features/movies/repo/movies_repo.dart';
import 'package:imdb_movies_app/features/movies/utils/movies_util.dart';
import 'package:imdb_movies_app/models/response.dart';

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

    emit(state.copyWith(
      moviesPopularPage: nextPage,
      moviesPopularResults: popularMoviesResults,
      moviesPopularTotalPages: totalPages,
      moviesPopularTotalResults: totalResults,
    ));

    return true;
  }
}
