import 'package:flutter/material.dart';
import 'package:latern_link/pages/settings/settings_view.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsController();
}

class SettingsController extends State<SettingsPage> with ControllerLoggy {
  @override
  void initState() {
    super.initState();
    loggy.debug('SettingsController initialized');
  }

  @override
  void dispose() {
    loggy.debug('SettingsController disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SettingsView(controller: this);
}
