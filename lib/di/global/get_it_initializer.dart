import 'package:get_it/get_it.dart';
import 'package:latern_link/data/datasource/localizations_datasource.dart';
import 'package:latern_link/data/datasource_impl/localizations_datasource_impl.dart';
import 'package:latern_link/data/localizations/language_cache_manager.dart';
import 'package:latern_link/data/repository/localizations_repository_impl.dart';
import 'package:latern_link/domain/repository/localizations_repository.dart';
import 'package:latern_link/domain/usecase/save_language_interactor.dart';
import 'package:latern_link/utils/mixins/logging_mixin.dart';
import 'package:latern_link/utils/responsive.dart';
import 'package:latern_link/utils/secure_storage.dart';

final getIt = GetIt.instance;

class GetItInitializer with GetItLoggy {
  static final GetItInitializer _singleton = GetItInitializer._internal();

  factory GetItInitializer() {
    return _singleton;
  }

  GetItInitializer._internal();

  void setUp() {
    bindingGlobal();
    bindingDatasource();
    bindingDataSourceImpl();
    bindingRepository();
    bindingInteractor();

    loggy.debug('setUp(): Setup successful');
  }

  void bindingGlobal() {
    getIt.registerSingleton(ResponsiveUtils());
    getIt.registerSingleton(Store());

    bindingCachingManager();

    loggy.debug('bindingGlobal(): bind successful');
  }

  void bindingCachingManager() {
    getIt.registerFactory<LanguageCacheManager>(() => LanguageCacheManager());

    loggy.debug('bindingCachingManager(): bind successful');
  }

  void bindingDatasource() {
    getIt.registerFactory<LocalizationsDatasource>(
      () => LocalizationsDatasourceImpl(getIt.get<LanguageCacheManager>()),
    );

    loggy.debug('bindingDatasource(): bind successful');
  }

  void bindingDataSourceImpl() {
    getIt.registerFactory(
      () => LocalizationsDatasourceImpl(getIt.get<LanguageCacheManager>()),
    );

    loggy.debug('bindingDataSourceImpl(): bind successful');
  }

  void bindingRepository() {
    getIt.registerFactory<LocalizationsRepository>(
      () =>
          LocalizationsRepositoryImpl(getIt.get<LocalizationsDatasourceImpl>()),
    );
  }

  void bindingInteractor() {
    getIt.registerLazySingleton<SaveLanguageInteractor>(
      () => SaveLanguageInteractor(getIt.get<LocalizationsRepository>()),
    );
  }
}
