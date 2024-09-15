import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_movies_app/config/router/router_paths.dart';
import 'package:imdb_movies_app/consts/api/api_path.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_collection_state.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_connection_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/movie_details.response.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/features/movies/widgets/bookmark.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movieData, super.key});

  final Results movieData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        InternetConnectionState internetConnectionState = context.read<InternetConnectionCubit>().state;

        if (internetConnectionState is LostInternetConnectionState) {
          MovieDetailsResponse movieDetails = MoviesHelper.handleCreateMovieDetailsObject(movieData);

          context.read<MoviesCubit>().handleSetMovieDetails(movieDetails);
        }

        context.push(RouterPaths.movieDetails, extra: movieData.id.toString());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.smallSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.minBorderRadius),
                    child: Image.network(
                      '${ApiPath.POSTER_BASE_URL}${movieData.posterPath}',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          width: 100,
                          height: 100,
                          AppAssets.defaultMovieImage,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.smallSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              '${movieData.title}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: AppDimens.mediumFontSize,
                                fontWeight: FontWeight.w600,
                                color: AppColorsLight.primaryTextColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                                  '${movieData.voteAverage?.toStringAsFixed(1)} / 10 IMDb',
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
                          SizedBox(
                            child: Wrap(
                              children: [
                                if (movieData.genreNames != null)
                                  ...movieData.genreNames!.map(
                                    (genreName) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: AppDimens.extraSmallSpacing,
                                          bottom: AppDimens.extraSmallSpacing,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: AppDimens.extraSmallPadding.h, horizontal: AppDimens.smallPadding.w),
                                          decoration: BoxDecoration(
                                            color: AppColorsLight.genreBackgroundColor,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            genreName,
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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Bookmark(
              movieData: movieData,
            )
          ],
        ),
      ),
    );
  }
}
