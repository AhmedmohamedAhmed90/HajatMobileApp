import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat/src/features/categories/logic/cubit/sub_categories_cubit.dart';
import 'package:hajat/src/features/categories/models/category.dart';
import 'package:hajat/src/features/common/ui/error_screen.dart';
import 'package:hajat/src/utilities/common.dart';

import '../../app/ui/widgets/error_card.dart';
import '../../products/ui/products.dart';

@RoutePage()
class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({super.key, required this.category});
  final Category category;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  late Products products;

  @override
  void initState() {
    // TODO: implement initState
    products = Products(
      categoryId: widget.category.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
        bloc: SubCategoriesCubit(widget.category.id.toString()),
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
                      // labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        Tab(
                          text: getApplocalizations(context)!.all,
                        ),
                        ...categories.map((e) => Tab(text: e.name)).toList(),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      products,
                      ...categories
                          .map((e) => Products(
                                categoryId: e.id,
                              ))
                          .toList()
                    ],
                  ),
                ),
              );
            },
            error: (message) => ErrorCard(message: message),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}