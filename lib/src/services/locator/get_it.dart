import 'package:get_it/get_it.dart';
import 'package:hajat_mobile_app/src/domain/repositories/theme_repository.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/app/cubit/cubit/theme_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/banners/logic/cubit/banner_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/brands/logic/cubit/brands_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/logic/categories_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/orders/logic/cubit/all_orders_cubit.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/dio/append_token_interceptor.dart';
import 'package:hajat_mobile_app/src/services/dio/dio_factory.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/services/storage/storage_service.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Register your services here
  getIt.registerSingleton<StorageService>(StorageService());

  getIt.registerLazySingleton<ThemeRepository>(() => ThemeRepository());

  getIt.registerLazySingleton<CartCubit>(() => CartCubit());

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());

  getIt.registerLazySingleton<ApiService>(() => ApiService(
      DioFactory(Consts.baseUrl, AppendTokenInterceptor()).create()));

  getIt.registerLazySingleton<Log>(() => Log());

  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  getIt.registerLazySingleton<BannersCubit>(() => BannersCubit());

  getIt.registerLazySingleton<BrandsCubit>(() => BrandsCubit());
  getIt.registerLazySingleton<CategoriesCubit>(() => CategoriesCubit());
  getIt.registerLazySingleton<AllOrdersCubit>(() => AllOrdersCubit());
}
