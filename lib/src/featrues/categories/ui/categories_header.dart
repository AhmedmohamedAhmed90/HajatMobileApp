import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/banners/logic/cubit/banner_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/brands/logic/cubit/brands_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/logic/categories_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/featrues/categories/ui/category_item.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/error_widget.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:shimmer/shimmer.dart';


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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Consts.gapVS,
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.75,
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
              title: "An error occurred", // Removed getApplocalizations(context)
              onRetry: () {
                getIt<CategoriesCubit>().loadCategories();
                getIt<BannersCubit>().getBanners();
                getIt<BrandsCubit>().getBrands();
              },
            ),
          ),
          orElse: () {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.orange[50]!,
              child: Padding(
                padding: Consts.paddingM,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consts.gapVS,
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: 9,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          category: Category(id: index, image: '', name: ','),
                        );
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
