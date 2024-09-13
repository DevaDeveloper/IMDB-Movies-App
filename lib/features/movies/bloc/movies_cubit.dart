import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';
import 'package:imdb_movies_app/features/movies/repo/movies_repo.dart';
import 'package:imdb_movies_app/models/response.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesState.initial());

  MoviesRepository moviesRepository = MoviesRepository();

  Future<bool> handleGetGenres() async {
    ResponseApp<GetGenreResponse>? result = await moviesRepository.getMovieGenres();

    if (result.isError) {
      return false;
    }

    List<Genres>? genresList = result.data?.genres ?? [];

    emit(state.copyWith(genres: genresList));

    print('GENRE STATE: ${state.genres}');

    return true;
  }
}
