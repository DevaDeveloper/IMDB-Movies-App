import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({required this.movieData, super.key});

  final Results movieData;

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  bool isInFavourites = false;

  @override
  void initState() {
    super.initState();

    handleCheckIsMovieInFavourites();
  }

  void handleCheckIsMovieInFavourites() {
    List<Results> favouriteMoviesState = context.read<MoviesCubit>().state.favouriteMovies ?? [];

    bool isInFavouriteMovies = MoviesHelper.checkIfMovieIsInFavourites(favouriteMoviesState, widget.movieData.id);

    setState(() {
      isInFavourites = isInFavouriteMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(listener: (context, state) {
      handleCheckIsMovieInFavourites();
    }, builder: (context, state) {
      return InkWell(
        onTap: () {
          context.read<MoviesCubit>().handleSetSingleFavouriteMovie(widget.movieData);
        },
        child: isInFavourites
            ? SvgPicture.asset(
                AppAssets.bookmarkFilledIcon,
                width: AppDimens.mediumIconSize,
                height: AppDimens.mediumIconSize,
              )
            : SvgPicture.asset(
                AppAssets.bookmarkEmptyIcon,
                width: AppDimens.mediumIconSize,
                height: AppDimens.mediumIconSize,
              ),
      );
    });
  }
}
