import 'package:flutter/material.dart';
import 'package:latern_link/config/app_config.dart';
import 'package:latern_link/config/app_routes.dart';
import 'package:latern_link/config/themes.dart';
import 'package:latern_link/di/global/get_it_initializer.dart';
import 'package:latern_link/src/rust/frb_generated.dart';
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
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: AppConfig.title,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      builder: (context, child) {
        return Scaffold(body: child);
      },
    );
  }
}
