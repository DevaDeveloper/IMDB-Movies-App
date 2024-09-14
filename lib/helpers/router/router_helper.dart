import 'package:imdb_movies_app/main.dart';

class RouterHelper {
  static String getCurrentRoute() {
    String currentRoute = mgRouter.routeInformationProvider.value.uri.toString();

    print('currentRoute: ${currentRoute}');

    return currentRoute;
  }
}
