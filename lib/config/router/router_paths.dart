class RouterPages {
  static const String path = '/';
  static const String homeScreen = 'home-screen';
  static const String favourites = 'favourites';
  static const String movieDetails = 'movie-details';
}

class RouterPaths {
  static const String home = RouterPages.path;
  static const String homeScreen = home + RouterPages.homeScreen;
  static const String favourites = home + RouterPages.favourites;
  static const String movieDetails = home + RouterPages.movieDetails;
}
