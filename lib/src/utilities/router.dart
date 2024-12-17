import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/onboarding_screen.dart';
// import 'package:hajat_mobile_app/src/features/auth/ui/auth_screen.dart';
// import 'package:hajat_mobile_app/src/features/home/ui/home_screen.dart';
// import 'package:hajat_mobile_app/src/features/cart/ui/cart_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page),
        AutoRoute(
          page: MyHomeRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: CartRoute.page,
              path: 'cart',
            ),
          ],
        ),
      ];
}
