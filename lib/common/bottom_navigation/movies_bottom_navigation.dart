import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_movies_app/config/router/router_paths.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/movies/models/screen_enum.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MoviesBottomNavigation extends StatelessWidget {
  const MoviesBottomNavigation({this.movieScreenEnum, super.key});

  final MovieScreenEnum? movieScreenEnum;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorsLight.bottomNavigationBackgroundColor,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context.go(RouterPaths.homeScreen);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: movieScreenEnum == MovieScreenEnum.popular ? AppColorsLight.primaryCheckedColor : Colors.transparent,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.moviesBottomSelected,
                      colorFilter: movieScreenEnum == MovieScreenEnum.popular
                          ? const ColorFilter.mode(AppColorsLight.primaryCheckedColor, BlendMode.srcIn)
                          : const ColorFilter.mode(AppColorsLight.primaryColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Movies',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: AppDimens.smallFontSize,
                        fontWeight: FontWeight.w600,
                        color: movieScreenEnum == MovieScreenEnum.popular
                            ? AppColorsLight.primaryCheckedColor
                            : AppColorsLight.primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                context.go(RouterPaths.favourites);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: movieScreenEnum == MovieScreenEnum.favourites ? AppColorsLight.primaryCheckedColor : Colors.transparent,
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.favouritesBottomUnSelected,
                      colorFilter: movieScreenEnum == MovieScreenEnum.favourites
                          ? const ColorFilter.mode(AppColorsLight.primaryCheckedColor, BlendMode.srcIn)
                          : const ColorFilter.mode(AppColorsLight.primaryColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Favourites',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: AppDimens.smallFontSize,
                        fontWeight: FontWeight.w400,
                        color: movieScreenEnum == MovieScreenEnum.favourites
                            ? AppColorsLight.primaryCheckedColor
                            : AppColorsLight.primaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
