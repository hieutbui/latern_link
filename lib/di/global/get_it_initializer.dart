import 'package:get_it/get_it.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';
import 'package:latern_link/utils/responsive.dart';

final getIt = GetIt.instance;

class GetItInitializer with GetItLoggy {
  static final GetItInitializer _singleton = GetItInitializer._internal();

  factory GetItInitializer() {
    return _singleton;
  }

  GetItInitializer._internal();

  void setUp() {
    bindingGlobal();

    loggy.debug('setUp(): Setup successful');
  }

  void bindingGlobal() {
    getIt.registerSingleton(ResponsiveUtils());

    loggy.debug('bindingGlobal(): bind successful');
  }

  void bindingServices() {
    loggy.debug('bindingServices(): bind successful');
  }
}