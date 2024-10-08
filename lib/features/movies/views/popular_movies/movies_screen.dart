import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imdb_movies_app/common/bottom_navigation/movies_bottom_navigation.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_collection_state.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_connection_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_state.dart';
import 'package:imdb_movies_app/features/movies/helper/movies_helper.dart';
import 'package:imdb_movies_app/features/movies/models/screen_enum.dart';
import 'package:imdb_movies_app/features/movies/widgets/movie_card.dart';
import 'package:imdb_movies_app/features/movies/widgets/movies_app_bar.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';
import 'package:imdb_movies_app/utils/bot_toast_notifications/bot_toast_notifications.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();

    handleFetchGenresAndPopularMovies();
  }

  Future<void> handleFetchGenresAndPopularMovies() async {
    final cancel = BotToast.showLoading();
    await context.read<MoviesCubit>().handleGetGenres();
    cancel();

    int? moviesPopularLength = MoviesHelper.handleGetPopularMoviesLength(context.read<MoviesCubit>().state.moviesPopularResults);

    if (MoviesHelper.isPopularMoviesInState(moviesPopularLength)) {
      return;
    }

    handleFetchPopularMovies();
  }

  Future<void> handleFetchPopularMovies() async {
    isLoadingMore = true;

    final loading = BotToast.showLoading();
    final response = await context.read<MoviesCubit>().handleGetPopularMovies();
    loading();

    isLoadingMore = false;

    if (!response) {
      return BotToastNotifications.showErrorNotification(context, 'Can not get movies, please try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.backgroundColor,
      appBar: const MoviesAppBar(),
      bottomNavigationBar: const MoviesBottomNavigation(
        movieScreenEnum: MovieScreenEnum.popular,
      ),
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
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollNotification) {
                    InternetConnectionState internetConnectionState = context.read<InternetConnectionCubit>().state;

                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (MoviesHelper.isFetchMorePopularMoviesValid(scrollNotification, isLoadingMore,
                              state.moviesPopularTotalPages ?? 1, state.moviesPopularPage ?? 1) &&
                          internetConnectionState is HasInternetConnectionState) {
                        handleFetchPopularMovies();
                      }
                    });
                    return true;
                  },
                  child: state.moviesPopularResults!.isEmpty
                      ? ListView.builder(
                          itemCount: state.cachedPopularMovies?.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movieData: state.cachedPopularMovies![index],
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: state.moviesPopularResults?.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movieData: state.moviesPopularResults![index],
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
