class RouterPages {
  static const String path = '/';
  static const String homeScreen = 'home-screen';
  static const String settings = 'settings';
}

class RouterPaths {
  static const String home = RouterPages.path;
  static const String homeScreen = home + RouterPages.homeScreen;
  static const String settings = homeScreen + home + RouterPages.settings;
}
