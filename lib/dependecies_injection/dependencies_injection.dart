import 'package:get_it/get_it.dart';
import 'package:posmobile/data/repository/auth_repository.dart';
import 'package:posmobile/data/repository/category_repository.dart';
import 'package:posmobile/data/repository/flavor_repository.dart';
import 'package:posmobile/data/repository/payment_method_repository.dart';
import 'package:posmobile/data/repository/payment_repository.dart';
import 'package:posmobile/data/repository/product_repository.dart';
import 'package:posmobile/data/repository/spicy_level_repository.dart';
import 'package:posmobile/data/repository/table_repository.dart';
import 'package:posmobile/data/repository/transaction_repository.dart';
import 'package:posmobile/service/service.dart';

final locator = GetIt.instance;

void dependenciesInjection() {
  // Register services
  locator.registerLazySingleton(() => ServiceHttpClient());

  // Register repositories
  locator.registerLazySingleton(
    () => AuthRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => FlavorRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => ProductRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => CategoryRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => SpicyLevelRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => TransactionRepository(locator<ServiceHttpClient>()),
  );
  locator.registerLazySingleton(
    () => PaymentMethodRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => TableRepository(locator<ServiceHttpClient>()),
  );

  locator.registerLazySingleton(
    () => PaymentRepository(locator<ServiceHttpClient>()),
  );
}
