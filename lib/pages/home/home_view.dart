import 'package:flutter/material.dart';
import 'package:latern_link/pages/home/home.dart';

class HomeView extends StatelessWidget {
  final HomeController controller;

  const HomeView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Home View', style: Theme.of(context).textTheme.displayLarge),
          const Spacer(),
          ElevatedButton(
            onPressed: () => controller.changeLanguage(Locale('vi')),
            child: const Text('Change VN Language'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.changeLanguage(Locale('en')),
            child: const Text('Change EN Language'),
          ),
        ],
      ),
    );
  }
}
