import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/account_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/onboarding_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/auth_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/reset_password_screen.dart';
import 'package:hajat_mobile_app/src/featrues/brands/models/brand.dart';
import 'package:hajat_mobile_app/src/featrues/brands/ui/brands_details_screen.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/featrues/categories/ui/category_details_screen.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/error_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/add_address_screen.dart';
import 'package:hajat_mobile_app/src/featrues/home/ui/home_screen.dart';
import 'package:hajat_mobile_app/src/featrues/home/ui/tabs/coupons.dart';
import 'package:hajat_mobile_app/src/featrues/home/ui/tabs/explore.dart';
import 'package:hajat_mobile_app/src/featrues/home/ui/tabs/more.dart';
import 'package:hajat_mobile_app/src/featrues/orders/models/order.dart';
import 'package:hajat_mobile_app/src/featrues/orders/ui/order_details_screen.dart';
import 'package:hajat_mobile_app/src/featrues/orders/ui/orders_screen.dart';
import 'package:hajat_mobile_app/src/featrues/products/models/product.dart';
import 'package:hajat_mobile_app/src/featrues/products/ui/product_details_screen.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/ui/cart_screen.dart';
import 'package:hajat_mobile_app/src/featrues/search/ui/search_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MyHomeRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: ExploreRoute.page,
              path: 'explore',
            ),
            AutoRoute(
              page: SearchRoute.page,
              path: 'search',
            ),
            AutoRoute(
              page: OrdersRoute.page,
              path: 'orders',
            ),
            AutoRoute(
              page: CartRoute.page,
              path: 'cart',
            ),
            AutoRoute(
              page: AccountRoute.page,
              path: 'account',
            ),
          ],
        ),
        AutoRoute(
          page: CategoryDetailsRoute.page,
        ),
        AutoRoute(page: ProductDetailsRoute.page),
        AutoRoute(page: ErrorRoute.page),
        AutoRoute(page: BrandsDetailsRoute.page),
        AutoRoute(page: AddAddressRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: OrderDetailsRoute.page),
      ];
}
