import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MoviesBottomNavigation extends StatelessWidget {
  const MoviesBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.starFilledIcon,
                  width: AppDimens.smallIconSize,
                  height: AppDimens.smallIconSize,
                ),
                Text(
                  'Movies',
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
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.starFilledIcon,
                  width: AppDimens.smallIconSize,
                  height: AppDimens.smallIconSize,
                ),
                Text(
                  'Favourites',
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
        ],
      ),
    );
  }
}
