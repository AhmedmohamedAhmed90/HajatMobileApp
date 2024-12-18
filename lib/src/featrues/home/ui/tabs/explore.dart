import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/brands/logic/cubit/brands_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/brands/ui/brands_header.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/banners/logic/cubit/banner_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/banners/ui/banner_header.dart';
import 'package:hajat_mobile_app/src/featrues/categories/logic/categories_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/ui/categories_header.dart';

import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/common.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';
import 'package:heroicons/heroicons.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getIt<CategoriesCubit>().loadCategories();
        getIt<BrandsCubit>().getBrands();
        getIt<BannersCubit>().getBanners();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Consts.paddingM,
                child: BlocBuilder<AuthCubit, AuthState>(
                  bloc: getIt<AuthCubit>(),
                  builder: (context, state) {
                    return state.maybeMap(
                      authenticated: (value) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.router.push(
                                      const AccountRoute(),
                                    );
                                  },
                                  child: HeroIcon(
                                    HeroIcons.userCircle,
                                    style: HeroIconStyle.solid,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 48,
                                  ),
                                ),
                                Consts.gapHS,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome", // to do for localization
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      value.session.user.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    )
                                  ],
                                )
                              ],
                            ),
                            if (value.session.user.street == null ||
                                value.session.user.latitude == null ||
                                value.session.user.longitude == null)
                              // alert the user to add their location
                              // this is a temporary solution
                              Container(
                                margin: Consts.paddingVS,
                                child: ListTile(
                                  title: Text(
                                    'locationMissing', // will change in localization
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  leading: const HeroIcon(
                                    HeroIcons.informationCircle,
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      context.router.push(
                                        const AddAddressRoute(),
                                      );
                                    },
                                    child: Text(
                                      'add location', // will change in localization
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Consts.borderRadiusM),
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ),
                            if (value.session.user.isVerified != null &&
                                !value.session.user.isVerified!)
                              // alert the user to verify their phone number
                              // this is a temporary solution
                              Container(
                                margin: Consts.paddingVS,
                                child: ListTile(
                                  title: Text(
                                    'phoneNotVerified', // will change in localization
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  leading: const HeroIcon(
                                    HeroIcons.informationCircle,
                                  ),
                                  trailing: TextButton(
                                    onPressed: () {
                                      // send otp
                                      getIt<AuthCubit>().sendOtp();
                                    },
                                    child: Text(
                                      'verifyPhone', // will change in localization
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Consts.borderRadiusM),
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                      orElse: () {
                        return const SizedBox();
                      },
                    );
                  },
                ),
              ),
              Consts.gapVL,
              const BannersHeader(),
              const Padding(
                padding: Consts.paddingHM,
                child: BrandsHeader(),
              ),
              const Padding(
                padding: Consts.paddingHM,
                child: CategoriesHeader(),
              ),

             
            ],
          ),
        ),
      ),
    );
  }
}
