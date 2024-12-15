import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/ui/cart_screen.dart';


part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
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
