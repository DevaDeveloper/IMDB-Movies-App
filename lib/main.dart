import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imdb_movies_app/config/router/router_paths.dart';
import 'package:imdb_movies_app/consts/hive/hive_consts.dart';
import 'package:imdb_movies_app/features/core/auth/bloc/auth_cubit.dart';
import 'package:imdb_movies_app/helpers/global_helpers.dart';
import 'package:imdb_movies_app/main/app_widget.dart';
import 'package:imdb_movies_app/utils/services/local_storage/shared_preferences_helper.dart';

import 'config/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  GlobalHelpers().loadEnvVariables();

  await Hive.initFlutter();

  final box = await Hive.openBox(HiveConsts.moviesBox);

  String languageCode = await SharedPreferencesHelper.getLanguageCode();
  String theme = await SharedPreferencesHelper.getTheme();
  String? token = await SharedPreferencesHelper.getToken();
  String? userId = await SharedPreferencesHelper.getUserId();

  runApp(MyApp(
    languageCode: languageCode,
    theme: theme,
    token: token,
    userId: userId,
  ));
}

final GoRouter mgRouter = GoRouter(
  observers: [BotToastNavigatorObserver()],
  initialLocation: RouterPaths.homeScreen,
  routes: appRoutes,
  routerNeglect: true,
  redirect: (context, routerState) {
    if (routerState.fullPath == RouterPaths.homeScreen && context.read<AuthCubit>().state is! AuthenticatedUser) {
      return RouterPaths.home;
    }

    return null;
  },
);
