import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:latern_link/app_state/failure.dart';
import 'package:latern_link/app_state/success.dart';
import 'package:latern_link/domain/repository/localizations_repository.dart';
import 'package:latern_link/domain/state/save_language_state.dart';

class SaveLanguageInteractor {
  final LocalizationsRepository _repository;

  SaveLanguageInteractor(this._repository);

  Stream<Either<Failure, Success>> execute(Locale localeCurrent) async* {
    try {
      yield Right(SavingLanguage());

      await _repository.persistLanguage(localeCurrent);

      yield Right(SaveLanguageSuccess(localeCurrent));
    } catch (exception) {
      yield Left(SaveLanguageFailure(exception));
    }
  }
}
