import 'package:flutter/material.dart';
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
    loggy.info('HomeController initialized');
  }

  @override
  void dispose() {
    loggy.info('HomeController disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => HomeView(controller: this);
}
