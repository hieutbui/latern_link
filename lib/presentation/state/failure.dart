import 'package:latern_link/app_state/failure.dart';

abstract class FeatureFailure extends Failure {
  final dynamic exception;

  const FeatureFailure({this.exception});

  @override
  List<Object?> get props => [exception];
}
