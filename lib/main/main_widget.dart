import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imdb_movies_app/features/core/auth/bloc/auth_cubit.dart';
import 'package:imdb_movies_app/styles/themes.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
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
          // listenWhen: (previousState, currentState) {
          //   return (previousState is AuthenticatedUser && currentState is UnauthenticatedUser) ||
          //       (currentState is AuthenticatedUser && previousState is! AuthenticatedUser);
          // },
          listener: (context, state) {
            if (state is UnauthenticatedUser) {}

            if (state is AuthenticatedUser) {
              print('User is Authenticated');
            }
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
