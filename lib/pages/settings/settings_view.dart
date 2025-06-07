import 'package:flutter/material.dart';
import 'package:latern_link/pages/settings/settings.dart';

class SettingsView extends StatelessWidget {
  final SettingsController controller;

  const SettingsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Settings View',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
