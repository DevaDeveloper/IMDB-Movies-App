import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc_providers_repositories.dart';
import 'main_widget.dart';

class MyApp extends StatelessWidget {
  final String languageCode;
  final String theme;
  final String? token;
  final String? userId;

  const MyApp({
    super.key,
    required this.languageCode,
    required this.theme,
    required this.token,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvidersRepositories(
      languageCode: languageCode,
      theme: theme,
      token: token,
      userId: userId,
      child: ScreenUtilInit(
        // If MediaQuery.of(context).size.shortestSide > 600 is true, device is considered as a tablet/iPad
        designSize: MediaQuery.of(context).size.shortestSide > 600 ? const Size(834, 1194) : const Size(393, 852),
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MainWidget();
        },
      ),
    );
  }
}
