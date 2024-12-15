import 'package:get_it/get_it.dart';
import 'package:hajat_mobile_app/src/domain/repositories/theme_repository.dart';

import 'package:hajat_mobile_app/src/utilities/consts.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Register your services here
  
  getIt.registerLazySingleton<ThemeRepository>(() => ThemeRepository());
}
