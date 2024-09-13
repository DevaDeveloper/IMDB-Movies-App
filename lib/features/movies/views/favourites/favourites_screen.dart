import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imdb_movies_app/common/bottom_navigation/movies_bottom_navigation.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/widgets/movie_card.dart';
import 'package:imdb_movies_app/features/movies/widgets/movies_app_bar.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class FavouritesScreem extends StatefulWidget {
  const FavouritesScreem({super.key});

  @override
  State<FavouritesScreem> createState() => _FavouritesScreemState();
}

class _FavouritesScreemState extends State<FavouritesScreem> {
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.backgroundColor,
      appBar: const MoviesAppBar(),
      bottomNavigationBar: const MoviesBottomNavigation(),
      body: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDimens.smallSpacing),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: AppDimens.largeFontSize,
                    fontWeight: FontWeight.w600,
                    color: AppColorsLight.primaryTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: AppDimens.mediumSpacing.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.moviesPopularResults?.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movieData: state.moviesPopularResults![index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
