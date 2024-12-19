import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/categories/logic/cubit/sub_categories_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/featrues/products/ui/products.dart';
import '../../app/ui/widgets/error_card.dart';

@RoutePage()
class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({super.key, required this.category});
  final Category category;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  late Products products;
  late SubCategoriesCubit subCategoriesCubit;

  @override
  void initState() {
    super.initState();
    products = Products(categoryId: widget.category.id);
    subCategoriesCubit = SubCategoriesCubit(widget.category.id);
  }

  @override
  void dispose() {
    subCategoriesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
        bloc: subCategoriesCubit,
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (categories) {
              return DefaultTabController(
                length: categories.length + 1,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(widget.category.name),
                    bottom: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        const Tab(text: 'All'),
                        ...categories.map((category) => Tab(text: category.name)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      products,
                      ...categories.map((category) => Products(
                            categoryId: category.id,
                          )),
                    ],
                  ),
                ),
              );
            },
            error: (message) => ErrorCard(message: message),
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}