import 'package:flutter/material.dart';
import 'package:latern_link/presentation/state/failure.dart';
import 'package:latern_link/presentation/state/success.dart';

class SavingLanguage extends UIState {}

class SaveLanguageSuccess extends UIState {
  final Locale localeStored;

  SaveLanguageSuccess(this.localeStored);

  @override
  List<Object?> get props => [localeStored];
}

class SaveLanguageFailure extends FeatureFailure {
  const SaveLanguageFailure(dynamic exception) : super(exception: exception);
}
