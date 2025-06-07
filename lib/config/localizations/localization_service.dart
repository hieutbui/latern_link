import 'package:flutter/material.dart';
import 'package:latern_link/config/localizations/language_code_constants.dart';
import 'package:latern_link/data/localizations/language_cache_manager.dart';
import 'package:latern_link/di/global/get_it_initializer.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';

class LocalizationService {
  static const defaultLocale = Locale(LanguageCodeConstants.english);
  static const fallbackLocale = Locale(LanguageCodeConstants.english);
  static final localeLoggy = getIt.get<LocaleLoggy>();

  static ValueNotifier<Locale> currentLocale = ValueNotifier(defaultLocale);

  static void changeLocale(BuildContext context, String languageCode) async {
    localeLoggy.loggy.debug('changeLocale(): languageCode: $languageCode');
  }

  static Future<Locale> getLocaleFromLanguage({
    required BuildContext context,
    String? languageCode,
  }) async {
    final languageCacheManager = getIt.get<LanguageCacheManager>();

    localeLoggy.loggy.debug(
      'LocalizationService::_getLocaleFromLanguage:languageCacheManager: $languageCacheManager',
    );
  }
}
