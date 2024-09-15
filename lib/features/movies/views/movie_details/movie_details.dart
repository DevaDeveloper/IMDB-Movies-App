import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_movies_app/consts/api/api_path.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/models/screen_enum.dart';
import 'package:imdb_movies_app/features/movies/widgets/bookmark.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';
import 'package:imdb_movies_app/utils/bot_toast_notifications/bot_toast_notifications.dart';

import '../../../internet_connection/bloc/internet_collection_state.dart';
import '../../../internet_connection/bloc/internet_connection_cubit.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({this.movieId, super.key});

  final String? movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    super.initState();

    handleFetchMovieDetails();
  }

  Future<void> handleFetchMovieDetails() async {
    if (widget.movieId == null) {
      return;
    }

    InternetConnectionState internetConnectionState = context.read<InternetConnectionCubit>().state;

    if (internetConnectionState is LostInternetConnectionState) {
      return;
    }

    final loading = BotToast.showLoading();
    final response = await context.read<MoviesCubit>().handleGetMovieDetails(widget.movieId!);
    loading();

    if (!response) {
      return BotToastNotifications.showErrorNotification(context, 'Can not get movie details, please try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.backgroundColor,
      body: SingleChildScrollView(
        child: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDimens.normalBorderRadius),
                        topRight: Radius.circular(AppDimens.normalBorderRadius),
                      ),
                      child: Image.network(
                        '${ApiPath.POSTER_BASE_URL}${state.movieDetails?.posterPath}',
                        height: 375,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            width: double.infinity,
                            AppAssets.defaultMovieImage,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Positioned(
                        left: 30,
                        top: 70,
                        child: InkWell(
                          onTap: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              AppAssets.movieDetailsBackArrow,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            state.movieDetails?.originalTitle ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: AppDimens.secondaryMediumFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppColorsLight.primaryTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Bookmark(
                          movieId: int.tryParse(widget.movieId!),
                          screenEnum: MovieScreenEnum.details,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.starFilledIcon,
                          width: AppDimens.smallIconSize,
                          height: AppDimens.smallIconSize,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${state.movieDetails?.voteAverage?.toStringAsFixed(1) ?? ''} / 10 IMDb',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: AppDimens.smallFontSize,
                            fontWeight: FontWeight.w400,
                            color: AppColorsLight.primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.movieDetails?.genres != null && state.movieDetails!.genres!.isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Wrap(
                              children: [
                                ...state.movieDetails!.genres!.map(
                                  (genre) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: AppDimens.extraSmallSpacing,
                                        bottom: AppDimens.extraSmallSpacing,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: AppDimens.extraSmallPadding, horizontal: AppDimens.smallPadding.sp),
                                        decoration: BoxDecoration(
                                          color: AppColorsLight.genreBackgroundColor,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          genre.name ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: AppDimens.smallFontSize,
                                            fontWeight: FontWeight.w400,
                                            color: AppColorsLight.primaryTextColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      'Description',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: AppDimens.mediumFontSize,
                        fontWeight: FontWeight.w400,
                        color: AppColorsLight.primaryTextColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      state.movieDetails?.overview ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: AppDimens.smallFontSize,
                        fontWeight: FontWeight.w300,
                        color: AppColorsLight.primaryTextColor,
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
