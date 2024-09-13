import 'package:equatable/equatable.dart';
import 'package:imdb_movies_app/features/movies/models/genre_response.dart';

class MoviesState extends Equatable {
  final List<Genres>? genres;

  const MoviesState({
    this.genres,
  });

  factory MoviesState.initial() {
    return const MoviesState(
      genres: [],
    );
  }

  MoviesState copyWith({
    List<Genres>? genres,
  }) {
    return MoviesState(
      genres: genres ?? this.genres,
    );
  }

  @override
  List<Object?> get props => [
        genres,
      ];
}
