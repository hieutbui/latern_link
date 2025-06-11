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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.checkAccessPermission(),
            child: const Text('Check Accessibility Permission'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.requestAccessPermission(),
            child: const Text('Request Accessibility Permission'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.checkRecordPermission(),
            child: const Text('Check Screen Recording Permission'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.requestRecordPermission(),
            child: const Text('Request Screen Recording Permission'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.checkFullDiskPermission(),
            child: const Text('Check Full Disk Access Permission'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.requestFullDiskPermission(),
            child: const Text('Request Full Disk Access Permission'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
