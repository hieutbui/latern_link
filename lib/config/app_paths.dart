import 'package:flutter/widgets.dart';
import 'package:latern_link/l10n/app_localizations/app_localizations.dart';

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

  String label(BuildContext context) {
    switch (this) {
      case AppPaths.home:
        return AppLocalizations.of(context)!.homePageTitle;
      case AppPaths.settings:
        return AppLocalizations.of(context)!.settingsPageTitle;
    }
  }
}
