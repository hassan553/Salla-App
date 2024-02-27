import 'package:get_it/get_it.dart';
import 'package:store_app/repository/auth_repo.dart';
import 'package:store_app/repository/home_repo.dart';

import '../../view_model/auth/auth_cubit.dart';
import '../../view_model/home/products_cubit.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // BLoCs
  locator.registerFactory(() => AuthCubit(authRepo: locator<AuthRepo>()));
  locator.registerFactory(() => ProductsCubit(locator<HomeRepo>())
    ..productsData()
    ..categoriesData());

  // Repositories
  locator.registerLazySingleton(() => AuthRepo());
  locator.registerLazySingleton(() => HomeRepo());
}
