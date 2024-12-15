import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hajat_mobile_app/src/domain/repositories/theme_repository.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static ThemeCubit get instance => getIt<ThemeCubit>();
  ThemeCubit() : super(const ThemeState(ThemeMode.system)) {
    loadTheme();
  }

  void updateTheme(ThemeMode themeMode) {
    final themeRepo = ThemeRepository.instance;
    themeRepo.saveTheme(themeMode);
    emit(ThemeState(themeMode));
  }

  void loadTheme() async {
    final themeRepo = getIt<ThemeRepository>();
    final themeMode = await themeRepo.loadFromPrefs();
    emit(ThemeState(themeMode));
  }
}
