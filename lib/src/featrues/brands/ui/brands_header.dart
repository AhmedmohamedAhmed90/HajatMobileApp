import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/brands/logic/cubit/brands_cubit.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';


import 'package:shimmer/shimmer.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class BrandsHeader extends StatelessWidget {
  const BrandsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsCubit, BrandsState>(
      bloc: getIt<BrandsCubit>(),
      builder: (context, state) {
        return state.maybeMap(
          loaded: (value) {
            return Container(
              padding: Consts.paddingVM,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap:
                          true, // Makes the ListView take up the height of its children
                      scrollDirection: Axis.horizontal,
                      itemCount: value.brands.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: index == 0
                              ? null
                              : const EdgeInsets.only(right: 12),
                          child: Material(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius:
                                BorderRadius.circular(Consts.borderRadiusM),
                            child: InkWell(
                              onTap: () {
                                // todo navigate to brand details
                                context.router.push(BrandsDetailsRoute(
                                    brand: value.brands[index]));
                              },
                              borderRadius:
                                  BorderRadius.circular(Consts.borderRadiusM),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      Consts.borderRadiusM),
                                ),
                                padding: Consts.paddingHM,
                                child: Text(
                                  value.brands[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          // error: (value) => ErrorCard(message: value.message),
          orElse: () {
            return const SizedBox();
          },
          loading: (value) {
            // show shimmer
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.orange[50]!,
              child: Container(
                width: double.infinity,
                padding: Consts.paddingM,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      // width: 100,

                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadiusM),
                      ),
                    ),
                  ),
                  Consts.gapHS,
                  Expanded(
                    child: Container(
                      // width: 100,

                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadiusM),
                      ),
                    ),
                  ),
                  Consts.gapHS,
                  Expanded(
                    child: Container(
                      // width: 100,

                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadiusM),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          },
        );
      },
    );
  }
}
