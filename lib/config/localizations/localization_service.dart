import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:latern_link/config/localizations/language_code_constants.dart';
import 'package:latern_link/data/localizations/language_cache_manager.dart';
import 'package:latern_link/di/global/get_it_initializer.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';
import 'package:collection/collection.dart';
import 'package:loggy/loggy.dart';

class LocalizationService with LocaleLoggy {
  static const defaultLocale = Locale(LanguageCodeConstants.english);
  static const fallbackLocale = Locale(LanguageCodeConstants.english);

  static ValueNotifier<Locale> currentLocale = ValueNotifier(defaultLocale);

  static final Loggy localeLoggy = Loggy<LocaleLoggy>('LocalizationService');

  static const List<Locale> supportedLocales = <Locale>[
    Locale(LanguageCodeConstants.english),
    Locale(LanguageCodeConstants.vietnamese),
  ];

  static void changeLocale(BuildContext context, String languageCode) async {
    localeLoggy.debug('changeLocale(): languageCode: $languageCode');
    final PlatformDispatcher platformDispatcher = View.of(
      context,
    ).platformDispatcher;

    final newLocale = await getLocaleFromLanguage(
      platformDispatcher: platformDispatcher,
      languageCode: languageCode,
    );

    localeLoggy.debug('changeLocale(): newLocale: $newLocale');

    currentLocale.value = newLocale;

    await WidgetsFlutterBinding.ensureInitialized().performReassemble();
  }

  static Future<Locale> getLocaleFromLanguage({
    required PlatformDispatcher platformDispatcher,
    String? languageCode,
  }) async {
    final languageCacheManager = getIt.get<LanguageCacheManager>();

    localeLoggy.debug(
      'LocalizationService::_getLocaleFromLanguage:languageCacheManager: $languageCacheManager',
    );

    final localeStored = await languageCacheManager.getStoredLanguage();

    localeLoggy.debug(
      'LocalizationService::_getLocaleFromLanguage:localeStored: $localeStored',
    );

    if (localeStored != null) {
      return localeStored;
    } else {
      final languageCodeCurrent =
          languageCode ?? platformDispatcher.locale.languageCode;

      localeLoggy.debug(
        'LocalizationService::_getLocaleFromLanguage:languageCodeCurrent: $languageCodeCurrent',
      );

      final localeStored = supportedLocales.firstWhereOrNull(
        (locale) => locale.languageCode == languageCodeCurrent,
      );

      return localeStored ?? platformDispatcher.locale;
    }
  }

  static Locale? localeResolutionCallback(
    Locale? deviceLocale,
    Iterable<Locale> supportedLocales,
  ) {
    localeLoggy.debug(
      'LocalizationService::localeResolutionCallback:deviceLocale: $deviceLocale',
    );

    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == deviceLocale?.languageCode) {
        localeLoggy.debug(
          'LocalizationService::localeResolutionCallback:matched: $deviceLocale',
        );
        return deviceLocale;
      }
    }

    localeLoggy.debug(
      'LocalizationService::localeResolutionCallback:first: ${supportedLocales.first}',
    );

    return supportedLocales.first;
  }
}
