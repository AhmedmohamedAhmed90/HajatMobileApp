import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/auth_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/otp_screen.dart';
import 'package:hajat_mobile_app/src/featrues/home/ui/tabs_screen.dart';
import 'package:hajat_mobile_app/src/featrues/splash/ui/splash_screen.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';

@RoutePage()
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: AuthCubit.instance,
      listener: (context, state) {
        state.maybeWhen(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                ),
                
              ),
            );


            getIt<Log>().error(message);
            // navigate to error screen
            // context.router.push(ErrorRoute(message: message));
          },
          authenticated: (session) {
            // check if the user doesn't have an address then navigate to address screen
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (auth) {
            return const TabsScreen();
          },
          otpSent: () {
            return OtpScreen();
          },
          otpWrongCode: () {
            return OtpScreen(isOtpWrong: true);
          },
          guest: () {
            return const TabsScreen(
              isGuest: true,
            );
          },

          loading: () {
            return const LoadingScreen();
          },
          orElse: () {
            return AuthScreen(
              isLogin: false,
            );
           
          },
        );
      },
    );
  }
}
