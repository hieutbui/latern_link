import 'package:flutter/material.dart';
import 'package:latern_link/pages/home/home.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;

  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home View',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
