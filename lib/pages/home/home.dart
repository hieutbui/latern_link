import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:latern_link/app_state/failure.dart';
import 'package:latern_link/app_state/success.dart';
import 'package:latern_link/config/localizations/localization_service.dart';
import 'package:latern_link/di/global/get_it_initializer.dart';
import 'package:latern_link/domain/state/save_language_state.dart';
import 'package:latern_link/domain/usecase/save_language_interactor.dart';
import 'package:latern_link/pages/home/home_view.dart';
import 'package:latern_link/src/rust/api.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomeController();
}

class HomeController extends State<HomePage> with ControllerLoggy {
  final saveLanguageInteractor = getIt.get<SaveLanguageInteractor>();

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
  }

  void onChangeENLanguage() {
    loggy.debug('Button pressed');
  }

  void changeLanguage(Locale selectedLocale) {
    saveLanguageInteractor
        .execute(selectedLocale)
        .listen(
          (event) => _handleSaveLanguageOnData(event),
          onDone: _handleSaveLanguageOnDone,
          onError: _handleSaveLanguageOnError,
        );
  }

  void _handleSaveLanguageOnData(Either<Failure, Success> event) {
    event.fold(
      (failure) => null,
      (success) => {
        if (success is SaveLanguageSuccess)
          {
            LocalizationService.changeLocale(
              context,
              success.localeStored.languageCode,
            ),
          },
      },
    );
  }

  void _handleSaveLanguageOnDone() {
    loggy.debug('SettingsAppLanguageController::_handleSaveLanguageOnDone()');
  }

  void _handleSaveLanguageOnError(Object error) {
    loggy.error(
      'SettingsAppLanguageController::_handleSaveLanguageOnError():error: $error',
    );
  }

  Future<bool> checkAccessPermission() async {
    loggy.debug('Checking accessibility permission');
    final hasPermission = await checkAccessibilityPermission();
    loggy.debug('Accessibility permission status: $hasPermission');

    return hasPermission;
  }

  Future<void> requestAccessPermission() async {
    loggy.debug('Requesting accessibility permission');

    await requestAccessibilityPermission();
  }

  Future<bool> checkRecordPermission() async {
    loggy.debug('Checking screen recording permission');
    final hasPermission = await checkScreenRecordingPermission();
    loggy.debug('Screen recording permission status: $hasPermission');

    return hasPermission;
  }

  Future<void> requestRecordPermission() async {
    loggy.debug('Requesting screen recording permission');
    await requestScreenRecordingPermission();
  }

  Future<bool> checkFullDiskPermission() async {
    loggy.debug('Checking full disk access permission');
    final hasPermission = await checkFullDiskAccessPermission();
    loggy.debug('Full disk access permission status: $hasPermission');

    return hasPermission;
  }

  Future<void> requestFullDiskPermission() async {
    loggy.debug('Requesting full disk access permission');
    await requestFullDiskAccessPermission();
    loggy.debug('Full disk access permission request completed');
  }

  Future<bool> isWindowsAdmin() async {
    loggy.debug('Checking Windows admin status');
    final isAdmin = await checkWindowsAdmin();
    loggy.debug('Windows admin status: $isAdmin');

    return isAdmin;
  }

  Future<void> requestWindowsAdminPrivileges() async {
    loggy.debug('Requesting Windows admin privileges');
    await requestWindowsAdmin();
    loggy.debug('Windows admin request completed');
  }

  @override
  Widget build(BuildContext context) => HomeView(controller: this);
}
