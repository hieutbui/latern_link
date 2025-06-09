import 'package:flutter/material.dart';
import 'package:latern_link/config/localizations/localization_service.dart';
import 'package:latern_link/pages/home/home_view.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomeController();
}

class HomeController extends State<HomePage> with ControllerLoggy {
  @override
  void initState() {
    super.initState();
    loggy.debug('HomeController initialized');
  }

  @override
  void dispose() {
    loggy.debug('HomeController disposed');
    super.dispose();
  }

  void onChangeVNLanguage() {
    loggy.debug('Button pressed');

    LocalizationService.changeLocale(context, 'vi');
  }

  void onChangeENLanguage() {
    loggy.debug('Button pressed');

    LocalizationService.changeLocale(context, 'en');
  }

  @override
  Widget build(BuildContext context) => HomeView(controller: this);
}
