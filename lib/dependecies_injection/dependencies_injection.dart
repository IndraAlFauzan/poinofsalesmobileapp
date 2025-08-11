import 'package:get_it/get_it.dart';
import 'package:posmobile/data/repository/auth_repository.dart';
import 'package:posmobile/service/service.dart';

final locator = GetIt.instance;

void dependenciesInjection() {
  // Register services
  locator.registerLazySingleton(() => ServiceHttpClient());

  // Register repositories
  locator.registerLazySingleton(
    () => AuthRepository(locator<ServiceHttpClient>()),
  );
}
