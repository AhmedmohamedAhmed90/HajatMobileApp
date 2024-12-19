import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_states.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';
import 'package:heroicons/heroicons.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({
    super.key,
    this.isGuest = false,
  });
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        ExploreRoute(),
        // SearchRoute(),
        AccountRoute(),
        CartRoute(),
        OrdersRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: SafeArea(child: child),
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) {
              if (isGuest && (index == 2 || index == 3)) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Guest User"),
                      content: const Text(
                          "Please login or register to access this feature."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.router.push(
                              AuthRoute(isLogin: true),
                            );
                          },
                          child: const Text("Login"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.router.push(
                              AuthRoute(isLogin: false),
                            );
                          },
                          child: const Text("Register"),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              tabsRouter.setActiveIndex(index);
            },
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            destinations: [
              NavigationDestination(
                label: "Home",
                icon: const HeroIcon(
                  HeroIcons.home,
                  style: HeroIconStyle.outline,
                ),
                selectedIcon: HeroIcon(
                  HeroIcons.home,
                  style: HeroIconStyle.solid,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              NavigationDestination(
                label: "Search",
                icon: const HeroIcon(
                  HeroIcons.magnifyingGlass,
                  style: HeroIconStyle.outline,
                ),
                selectedIcon: HeroIcon(
                  HeroIcons.magnifyingGlass,
                  style: HeroIconStyle.solid,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              NavigationDestination(
                label: "Cart",
                icon: Stack(
                  children: [
                    const HeroIcon(
                      HeroIcons.shoppingCart,
                      style: HeroIconStyle.outline,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: getIt<CartCubit>(),
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (cart) {
                            if (cart.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Positioned(
                              right: 0,
                              top: 0,
                              child: Badge(
                                label: Text(cart.length.toString()),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                selectedIcon: Stack(
                  children: [
                    HeroIcon(
                      HeroIcons.shoppingCart,
                      style: HeroIconStyle.solid,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: getIt<CartCubit>(),
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox.shrink();
                          },
                          loaded: (cart) {
                            if (cart.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Positioned(
                              right: 0,
                              top: 0,
                              child: Badge(
                                label: Text(cart.length.toString()),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              NavigationDestination(
                label: "Orders",
                icon: const HeroIcon(
                  HeroIcons.truck,
                  style: HeroIconStyle.outline,
                ),
                selectedIcon: HeroIcon(
                  HeroIcons.truck,
                  style: HeroIconStyle.solid,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              NavigationDestination(
                label: "Account",
                icon: const HeroIcon(
                  HeroIcons.user,
                  style: HeroIconStyle.outline,
                ),
                selectedIcon: HeroIcon(
                  HeroIcons.user,
                  style: HeroIconStyle.solid,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          floatingActionButton: isGuest
              ? FloatingActionButton.extended(
                  onPressed: () {
                    context.router.push(const OnboardingRoute());
                  },
                  icon: const Icon(
                    Icons.login,
                  ),
                  label: const Text("Register"),
                )
              : null,
        );
      },
    );
  }
}
