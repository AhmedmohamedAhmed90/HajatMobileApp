import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/auth/models/user.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  User? user = getIt<AuthCubit>().state.maybeMap(
                        authenticated: (state) => state.session.user,
                        orElse: () => null,
                      );
                  context.router.push(ResetPasswordRoute(
                    phone: user!.phone,
                  ));
                },
                child: Container(
                  padding: Consts.paddingM,
                  margin: Consts.paddingHMVS,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Consts.borderRadiusM),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF404651).withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 17,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.grey.shade600,
                      ),
                      Consts.gapM,
                      Expanded(
                        child: Text(
                          'Reset Password',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //context.router.push(const WalletRoute());
                },
                child: Container(
                  padding: Consts.paddingM,
                  margin: Consts.paddingHMVS,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Consts.borderRadiusM),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF404651).withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 17,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wallet,
                        color: Colors.grey.shade600,
                      ),
                      Consts.gapM,
                      Expanded(
                        child: Text(
                          'Wallet',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.router.push(const AddAddressRoute());
                },
                child: Container(
                  padding: Consts.paddingM,
                  margin: Consts.paddingHMVS,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Consts.borderRadiusM),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF404651).withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 17,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: Colors.grey.shade600,
                      ),
                      Consts.gapM,
                      Expanded(
                        child: Text(
                          'Update Address',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  getIt<AuthCubit>().logout();
                  context.router.popUntil((route) => route.isFirst);
                },
                child: Container(
                  padding: Consts.paddingM,
                  margin: Consts.paddingHMVS,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Consts.borderRadiusM),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF404651).withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 17,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red.shade600,
                      ),
                      Consts.gapM,
                      Expanded(
                        child: Text(
                          'Logout',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                          'Are you sure you want to delete your account? This action cannot be undone.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              getIt<AuthCubit>().logout();
                              context.router.popUntil((route) => route.isFirst);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  padding: Consts.paddingM,
                  margin: Consts.paddingHMVS,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Consts.borderRadiusM),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF404651).withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 17,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade600,
                      ),
                      Consts.gapM,
                      Expanded(
                        child: Text(
                          'Delete Account',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}