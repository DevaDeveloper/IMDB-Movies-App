import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_movies_app/consts/api/api_path.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({required this.movieData, super.key});

  final Results movieData;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    print('${widget.movieData.posterPath}');
    return Padding(
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
                    '${ApiPath.POSTER_BASE_URL}${widget.movieData.posterPath}',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiDutvktAoaPzmjTPvbCxlRVOYCSytoUUU1Q&s',
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.smallSpacing),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            '${widget.movieData.title}',
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
                                '${widget.movieData.voteAverage} / 10 IMDb',
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
                              ...['Comedy', 'Adventure', 'Action'].map(
                                (genreName) {
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
          SvgPicture.asset(
            AppAssets.bookmarkEmptyIcon,
            width: AppDimens.mediumIconSize,
            height: AppDimens.mediumIconSize,
          ),
        ],
      ),
    );
  }
}
