import 'package:flutter/material.dart';
import 'package:latern_link/data/datasource/localizations_datasource.dart';
import 'package:latern_link/domain/repository/localizations_repository.dart';

class LocalizationsRepositoryImpl extends LocalizationsRepository {
  final LocalizationsDatasource _datasource;

  LocalizationsRepositoryImpl(this._datasource);

  @override
  Future<void> persistLanguage(Locale locale) async {
    await _datasource.persistLanguage(locale);
  }
}
