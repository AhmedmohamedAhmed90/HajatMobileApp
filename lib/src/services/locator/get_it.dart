import 'package:get_it/get_it.dart';
import 'package:hajat_mobile_app/src/domain/repositories/theme_repository.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/dio/append_token_interceptor.dart';
import 'package:hajat_mobile_app/src/services/dio/dio_factory.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';


GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Register your services here
  
  getIt.registerLazySingleton<ThemeRepository>(() => ThemeRepository());

    getIt.registerLazySingleton<CartCubit>(() => CartCubit());

    getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());

    getIt.registerLazySingleton<ApiService>(() => ApiService(
      DioFactory(Consts.baseUrl, AppendTokenInterceptor()).create()));

        getIt.registerLazySingleton<Log>(() => Log());


}
