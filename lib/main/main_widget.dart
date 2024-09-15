import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:imdb_movies_app/features/core/auth/bloc/auth_cubit.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_collection_state.dart';
import 'package:imdb_movies_app/features/movies/bloc/movies_cubit.dart';
import 'package:imdb_movies_app/features/movies/helper/hive/hive_helper.dart';
import 'package:imdb_movies_app/features/movies/models/hive/movies.dart';
import 'package:imdb_movies_app/features/movies/models/hive/results.dart' as hiveResults;
import 'package:imdb_movies_app/features/movies/models/popular_movies_response.dart';
import 'package:imdb_movies_app/styles/themes.dart';
import 'package:imdb_movies_app/utils/bot_toast_notifications/bot_toast_notifications.dart';
import 'package:imdb_movies_app/utils/services/hive/hive_service.dart';

import '../features/internet_connection/bloc/internet_connection_cubit.dart';
import '../main.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    initConnectivity();
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    handleSetCachedFavouriteMoviesToAppState();

    handleSetCachedPopularMovesToAppState();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status $e');
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    result = await _connectivity.checkConnectivity();

    setState(() {
      _connectionStatus = result;
    });

    if (_connectionStatus == ConnectivityResult.none) {
      context.read<InternetConnectionCubit>().handleLostInternetConnection();
    } else if (_connectionStatus == ConnectivityResult.mobile || _connectionStatus == ConnectivityResult.wifi) {
      context.read<InternetConnectionCubit>().handleHasInternetConnection();
    }
  }

  void handleSetCachedFavouriteMoviesToAppState() {
    Box<Movies> moviesBox = HiveService.handleGetHiveBox();

    Movies? favouriteMovies = HiveService.handleGetFavouriteMoviesFromHiveByKey(moviesBox);

    List<hiveResults.Results> cachedFavouriteMovies = [...favouriteMovies?.favouriteMovies ?? []];

    List<Results> favouriteResults = HiveHelper.handleMappingCacheData(cachedFavouriteMovies);

    context.read<MoviesCubit>().handleSetMultipleFavouriteMovies(favouriteResults);
  }

  void handleSetCachedPopularMovesToAppState() {
    Box<Movies> moviesBox = HiveService.handleGetHiveBox();

    Movies? popularMovies = HiveService.handleGetPopularMoviesFromHiveByKey(moviesBox);

    List<hiveResults.Results> cachedPopularMovies = [...popularMovies?.popularMovies ?? []];

    List<Results> popularResults = HiveHelper.handleMappingCacheData(cachedPopularMovies);

    context.read<MoviesCubit>().handleSetMultiplePopularMovies(popularResults);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // App went to Background
    }

    if (state == AppLifecycleState.resumed) {
      // App came back to Foreground
    }
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is UnauthenticatedUser) {}

            if (state is AuthenticatedUser) {}
          },
        ),
        BlocListener<InternetConnectionCubit, InternetConnectionState>(
          listener: (context, state) {
            if (state is LostInternetConnectionState) {
              BotToastNotifications.showErrorNotification(context, 'Please check your internet connection');
            }
            if (state is HasInternetConnectionState) {}
          },
        ),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            widget = BotToastInit()(context, widget);

            return widget;
          },
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: ThemeMode.light,
          routerDelegate: mgRouter.routerDelegate,
          routeInformationParser: mgRouter.routeInformationParser,
          routeInformationProvider: mgRouter.routeInformationProvider,
        ),
      ),
    );
  }
}
