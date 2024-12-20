import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/products/models/product.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

import 'package:hive_flutter/hive_flutter.dart';

@RoutePage()
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
          overflow: TextOverflow.ellipsis, // Prevent overflow in the app bar title
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 50,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: Hero(
                      tag: widget.product.id,
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        height: 300,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  Consts.gapM,

                  // Title & Price
                  Padding(
                    padding: Consts.paddingM,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow.ellipsis, // Handle overflow
                                maxLines: 1, // Limit to one line
                              ),
                            ),
                            Container(
                              margin: Consts.paddingHS,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: widget.product.qtyAvailable == 0
                                    ? Colors.redAccent
                                    : Colors.green,
                                borderRadius:
                                    BorderRadius.circular(Consts.borderRadiusM),
                              ),
                              child: Text(
                                widget.product.qtyAvailable == 0
                                    ? 'Out of Stock'
                                    : 'In Stock',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                overflow: TextOverflow.ellipsis, // Handle overflow
                              ),
                            ),
                          ],
                        ),
                        Consts.gapM,
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: Text(
                                widget.product.category.name,
                                overflow: TextOverflow.ellipsis, // Handle overflow
                                maxLines: 1,
                              ),
                            ),
                            Chip(
                              label: Text(
                                widget.product.brand.name,
                                overflow: TextOverflow.ellipsis, // Handle overflow
                                maxLines: 1,
                              ),
                            ),
                            if (widget.product.qtyAvailable != 0)
                              Chip(
                                label: Text(
                                  "Available: ${widget.product.qtyAvailable} pieces",
                                  overflow: TextOverflow.ellipsis, // Handle overflow
                                  maxLines: 1,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(Consts.borderRadiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 50,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                padding: Consts.paddingM,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity controller
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Consts.borderRadiusS),
                            color: Colors.grey.shade100,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                    }
                                  });
                                },
                              ),
                              Text(
                                quantity.toString(),
                                overflow: TextOverflow.ellipsis, // Handle overflow
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Total price
                        Expanded(
                          child: Text(
                            "${(widget.product.listPrice * quantity).toStringAsFixed(2)} USD",
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ),
                      ],
                    ),
                    Consts.gapM,
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        child: const Text('Add to Cart'),
                        onPressed: () {
                          getIt<CartCubit>()
                              .addToCart(widget.product, quantity);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${widget.product.name} added to cart!'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          context.router.maybePop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
