import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/banners/logic/cubit/banner_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/logic/categories_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/featrues/categories/ui/category_item.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/error_widget.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import '../../app/ui/widgets/error_card.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      bloc: getIt<CategoriesCubit>(),
      builder: (context, state) {
        return state.maybeMap(
          loaded: (value) {
            return SizedBox(
              // padding: Consts.paddingVS,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   getApplocalizations(context)!.categories,
                  //   style: Theme.of(context).textTheme.headlineSmall,
                  // ),

                  const Divider(),
                  Consts.gapVS,
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio:
                          0.75, // Adjust this ratio to fit your design
                    ),
                    itemCount: value.categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CategoryItem(category: value.categories[index]);
                    },
                  ),
                ],
              ),
            );
          },
          error: (value) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ErrorrWidget(
              message: value.message,
              title: getApplocalizations(context)!.errorOccurred,
              onRetry: () {
                getIt<CategoriesCubit>().loadCategories();
                getIt<BannersCubit>().getBanners();
                getIt<BrandsCubit>().getBrands();
              },
            ),
          ),
          orElse: () {
            // show shimmer
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.orange[50]!,
              child: Padding(
                padding: Consts.paddingM,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   getApplocalizations(context)!.categories,
                    //   style: Theme.of(context).textTheme.titleLarge,
                    // ),
                    Consts.gapVS,
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio:
                            0.75, // Adjust this ratio to fit your design
                      ),
                      itemCount: 9,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // return CategoryItem(category: value.categories[index]);
                        return CategoryItem(
                            category:
                                Category(id: index, image: '', name: ','));
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
