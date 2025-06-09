import 'dart:ui';

abstract class LocalizationsDatasource {
  Future<void> persistLanguage(Locale localeCurrent);
}
