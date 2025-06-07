import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:latern_link/config/app_paths.dart';
import 'package:latern_link/config/route_change_notifier.dart';
import 'package:latern_link/di/global/get_it_initializer.dart';
import 'package:latern_link/pages/home/home.dart';
import 'package:latern_link/pages/settings/settings.dart';
import 'package:latern_link/utils/responsive.dart';
import 'package:latern_link/widgets/app_layout.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> get _rootNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Root Navigator');
  static GlobalKey<NavigatorState> get _shellNavigatorKey =>
      GlobalKey<NavigatorState>(debugLabel: 'Shell Navigator');

  static final _responsive = getIt.get<ResponsiveUtils>();

  static List<NavigationDestination> destinations(BuildContext context) =>
      <NavigationDestination>[
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: AppPaths.home.label,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          label: AppPaths.settings.label,
        ),
      ];

  static List<NavigationRailDestination> railDestinations(
    BuildContext context,
  ) => destinations(context)
      .map((destination) => AdaptiveScaffold.toRailDestination(destination))
      .toList();

  static final GoRouter router = GoRouter(
    initialLocation: AppPaths.home.path,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: routeChangeNotifier,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppLayout(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: AppPaths.home.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const HomePage(),
              name: AppPaths.home.label,
            ),
          ),
          GoRoute(
            path: AppPaths.settings.path,
            pageBuilder: (context, state) => defaultPageBuilder(
              context,
              const SettingsPage(),
              name: AppPaths.settings.label,
            ),
          ),
        ],
      ),
    ],
    onException: (context, state, router) {
      return router.go(AppPaths.home.path);
    },
  );

  static Page defaultPageBuilder(
    BuildContext context,
    Widget child, {
    String? name,
  }) => CustomTransitionPage(
    name: name,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        !_responsive.isMobile(context)
        ? FadeTransition(opacity: animation, child: child)
        : CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child,
          ),
  );

  static Map<String, int> navBarPathToIndex = {
    AppPaths.home.path: 0,
    AppPaths.settings.path: 1,
  };

  static Map<int, AppPaths> navBarIndexToPath = {
    0: AppPaths.home,
    1: AppPaths.settings,
  };
}
