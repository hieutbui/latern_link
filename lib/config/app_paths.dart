enum AppPaths {
  home,
  settings;

  String get path {
    switch (this) {
      case AppPaths.home:
        return '/';
      case AppPaths.settings:
        return '/settings';
    }
  }

  String get navigationPath {
    switch (this) {
      case AppPaths.home:
        return '/home';
      case AppPaths.settings:
        return '/settings';
    }
  }

  //TODO: Handle localization properly
  String get label {
    switch (this) {
      case AppPaths.home:
        return 'Home';
      case AppPaths.settings:
        return 'Settings';
    }
  }
}