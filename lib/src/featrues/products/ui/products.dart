import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/app/ui/widgets/error_card.dart';
import 'package:hajat_mobile_app/src/featrues/products/logic/cubit/products_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/products/ui/product_card.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

class Products extends StatefulWidget {
  Products({
    super.key,
    this.categoryId,
    this.brandId,
  });
  final int? categoryId;
  final int? brandId;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late ProductsCubit cubit;
  @override
  void initState() {
    cubit = ProductsCubit(widget.categoryId, widget.brandId);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      bloc: cubit,
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (products) {
            if (products.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.grey,
                  ),
                  Text(
                    'No data available', // Replace with your preferred string
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ));
            }
            return GridView.count(
              padding: Consts.paddingM,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              children: products
                  .map((product) => ProductCard(product: product))
                  .toList(),
            );
          },
          error: (message) => ErrorCard(message: message),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
