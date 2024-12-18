import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/app/cubit/cubit/theme_cubit.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';

import 'package:hajat_mobile_app/src/utilities/themes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: ThemeCubit.instance,
      builder: (context, state) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: state.themeMode,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
