import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';


@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Consts.paddingXL,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consts.gapXL, Consts.gapXL, Consts.gapXL,
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                padding: Consts.paddingXXL,
                child: Image.asset(
                  'assets/images/onboarding.png',
                  width: 200,
                  height: 200,
                ),
              ),
              // Consts.gapXL,
              const Spacer(),
              Column(
                children: [
                  Text(
                    'Welcome to Hajat',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Consts.gapXL,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      child: Text('Register'),
                      onPressed: () {
                        context.router.push(AuthRoute(
                          isLogin: false,
                        ));
                      },
                    ),
                  ),
                  Consts.gapS,
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonal(
                      child: Text('Login'),
                      onPressed: () {
                        context.router.push(AuthRoute(
                          isLogin: true,
                        ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text('Register Later'),
                      onPressed: () {
                        context.router.maybePop();
                        getIt<AuthCubit>().loginAsGuest();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
