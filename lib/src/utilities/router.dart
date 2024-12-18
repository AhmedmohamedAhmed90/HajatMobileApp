import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/account_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/onboarding_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/auth_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/reset_password_screen.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/featrues/categories/ui/category_details_screen.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/error_screen.dart';
import 'package:hajat_mobile_app/src/featrues/auth/ui/add_address_screen.dart';
import 'package:hajat_mobile_app/src/featrues/products/models/product.dart';
import 'package:hajat_mobile_app/src/featrues/products/ui/product_details_screen.dart'; 


part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page),
        // AutoRoute(
        //   page: MyHomeRoute.page,
        //   initial: true,
        //   children: [
        //     AutoRoute(
        //       page: CartRoute.page,
        //       path: 'cart',
        //     ),
        //   ],
        // ),
        AutoRoute(page: ResetPasswordRoute.page),

        //AutoRoute(page: WalletRoute.page),

        AutoRoute(page: AddAddressRoute.page),


      ];
}