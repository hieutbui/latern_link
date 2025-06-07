import 'package:loggy/loggy.dart';

mixin ControllerLoggy implements LoggyType {
  @override
  Loggy<ControllerLoggy> get loggy => Loggy<ControllerLoggy>('Controller Loggy - $runtimeType');
}

mixin GetItLoggy implements LoggyType {
  @override
  Loggy<GetItLoggy> get loggy =>
      Loggy<GetItLoggy>('GetIt Loggy - $runtimeType');
}

mixin ServiceLoggy implements LoggyType {
  @override
  Loggy<ServiceLoggy> get loggy =>
      Loggy<ServiceLoggy>('Service Loggy - $runtimeType');
}

mixin LocaleLoggy implements LoggyType {
  @override
  Loggy<LocaleLoggy> get loggy =>
      Loggy<LocaleLoggy>('Locale Loggy - $runtimeType');
}

mixin DataLoggy implements LoggyType {
  @override
  Loggy<DataLoggy> get loggy => Loggy<DataLoggy>('Data Loggy - $runtimeType');
}
