import 'package:conet/config/app_config.dart';
import 'package:conet/services/storage_service.dart';
import 'package:get_it/get_it.dart';

/// Global instance to access classes registerd with get_it.
final GetIt locator = GetIt.instance;

///
/// Register services and providers.
///
void registerServicesWithGetIt() {
  locator.registerSingleton<AppConfig>(AppConfig());
  locator.registerLazySingleton<StorageService>(() => StorageService());
}
