import 'package:flutter/material.dart';
import 'package:latern_link/config/app_config.dart';
import 'package:latern_link/config/app_routes.dart';
import 'package:latern_link/config/localizations/localization_service.dart';
import 'package:latern_link/config/themes.dart';
import 'package:latern_link/di/global/get_it_initializer.dart';
import 'package:latern_link/l10n/app_localizations/app_localizations.dart';
import 'package:latern_link/src/rust/frb_generated.dart';
import 'package:latern_link/utils/custom_scroll_behavior.dart';
import 'package:latern_link/widgets/theme_builder.dart';
import 'package:loggy/loggy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetItInitializer().setUp();

  await RustLib.init();

  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));

  runApp(const LaternLinkApp());
}

class LaternLinkApp extends StatelessWidget {
  const LaternLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, themeMode, primaryColor) => ValueListenableBuilder(
        valueListenable: LocalizationService.currentLocale,
        builder: (context, locale, _) {
          return MaterialApp.router(
            restorationScopeId: AppConfig.restorationScopeId,
            debugShowCheckedModeBanner: false,
            scrollBehavior: CustomScrollBehavior(),
            routerConfig: AppRoutes.router,
            title: AppConfig.title,
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            localeResolutionCallback:
                LocalizationService.localeResolutionCallback,
            builder: (context, child) {
              return Scaffold(body: child);
            },
          );
        },
      ),
    );
  }
}
