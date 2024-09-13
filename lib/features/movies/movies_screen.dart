// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imdb_movies_app/common/bottom_navigation/movies_bottom_navigation.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/widgets/movie_card.dart';
import 'package:imdb_movies_app/features/movies/widgets/movies_app_bar.dart';
import 'package:imdb_movies_app/styles/app_dimens.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();

    context.read<MoviesCubit>().handleGetGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.backgroundColor,
      appBar: const MoviesAppBar(),
      bottomNavigationBar: MoviesBottomNavigation(),
      body: Padding(
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
                itemCount: 7,
                itemBuilder: (context, index) {
                  return MovieCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
