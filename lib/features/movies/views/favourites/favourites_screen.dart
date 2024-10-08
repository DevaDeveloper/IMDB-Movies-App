import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imdb_movies_app/common/bottom_navigation/movies_bottom_navigation.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/models/screen_enum.dart';
import 'package:imdb_movies_app/features/movies/widgets/movie_card.dart';
import 'package:imdb_movies_app/features/movies/widgets/movies_app_bar.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
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
      bottomNavigationBar: const MoviesBottomNavigation(
        movieScreenEnum: MovieScreenEnum.favourites,
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppDimens.smallSpacing),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favourites',
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
                  itemCount: state.favouriteMovies?.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movieData: state.favouriteMovies![index],
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
