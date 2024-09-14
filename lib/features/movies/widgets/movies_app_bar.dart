import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MoviesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoviesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColorsLight.backgroundColor,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.smallSpacing.w),
        child: SvgPicture.asset(
          AppAssets.logo,
          width: AppDimens.mediumIconSize,
          height: AppDimens.mediumIconSize,
          colorFilter: const ColorFilter.mode(
            AppColorsLight.primaryCheckedColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
