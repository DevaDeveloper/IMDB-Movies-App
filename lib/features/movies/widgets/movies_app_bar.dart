import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imdb_movies_app/consts/assets/assets_path.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_collection_state.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_connection_cubit.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MoviesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MoviesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColorsLight.backgroundColor,
      leading: Row(
        children: [
          Padding(
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
          BlocBuilder<InternetConnectionCubit, InternetConnectionState>(builder: (context, state) {
            return Visibility(
                visible: state is LostInternetConnectionState,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.smallSpacing.w),
                    child: Icon(
                      Icons.signal_wifi_connected_no_internet_4_outlined,
                      color: AppColorsLight.primaryColor,
                      size: AppDimens.mediumIconSize,
                    )));
          }),
        ],
      ),
      leadingWidth: 100,
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
