import 'dart:ui';
import 'package:latern_link/data/datasource/localizations_datasource.dart';
import 'package:latern_link/data/localizations/language_cache_manager.dart';

class LocalizationsDatasourceImpl extends LocalizationsDatasource {
  final LanguageCacheManager _languageCacheManager;

  LocalizationsDatasourceImpl(this._languageCacheManager);

  @override
  Future<void> persistLanguage(Locale localeCurrent) async {
    await _languageCacheManager.persistLanguage(localeCurrent);
  }
}
