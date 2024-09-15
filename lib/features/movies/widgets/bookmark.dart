import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/movie_details.response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/features/movies/models/screen_enum.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({this.movieData, this.movieId, this.screenEnum, super.key});

  final Results? movieData;
  final int? movieId;
  final MovieScreenEnum? screenEnum;

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

    bool isInFavouriteMovies = false;

    if (widget.screenEnum == MovieScreenEnum.details) {
      isInFavouriteMovies = MoviesHelper.checkIfMovieIsInFavourites(favouriteMoviesState, widget.movieId);
    }

    if (widget.screenEnum != MovieScreenEnum.details) {
      isInFavouriteMovies = MoviesHelper.checkIfMovieIsInFavourites(favouriteMoviesState, widget.movieData?.id);
    }

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
        customBorder: const CircleBorder(),
        splashColor: AppColorsLight.primaryCheckedColor,
        onTap: () {
          if (widget.screenEnum == MovieScreenEnum.details) {
            MovieDetailsResponse? movieDetails = state.movieDetails;

            if (movieDetails == null) {
              return;
            }

            Results movieData = MoviesHelper.handleCreateMovieObject(movieDetails);

            context.read<MoviesCubit>().handleSetSingleFavouriteMovie(movieData);

            return;
          }

          context.read<MoviesCubit>().handleSetSingleFavouriteMovie(widget.movieData!);
        },
        child: isInFavourites
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.extraSmallSpacing.w, vertical: AppDimens.minSpacing.h),
                child: SvgPicture.asset(
                  AppAssets.bookmarkFilledIcon,
                  width: AppDimens.mediumIconSize,
                  height: AppDimens.mediumIconSize,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.extraSmallSpacing.h, vertical: AppDimens.minSpacing.h),
                child: SvgPicture.asset(
                  AppAssets.bookmarkEmptyIcon,
                  width: AppDimens.mediumIconSize,
                  height: AppDimens.mediumIconSize,
                ),
              ),
      );
    });
  }
}
