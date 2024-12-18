import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/products/models/product.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(ProductDetailsRoute(product: product));
      },
      child: Container(
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
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Consts.borderRadiusM),
                      topRight: Radius.circular(Consts.borderRadiusM),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Consts.borderRadiusM),
                      topRight: Radius.circular(Consts.borderRadiusM),
                    ),
                    child: Hero(
                      tag: product.id,
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            'assets/images/placeholder.jpg',
                            fit: BoxFit.cover,
                          );
                        },
                        placeholder: (context, url) => const Image(
                          image: AssetImage('assets/images/placeholder.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: Consts.paddingHM,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${product.listPrice.toStringAsFixed(2)} USD", // Static currency string
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.75),
                          ),
                      maxLines: 1,
                    ),
                    Consts.gapS,
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          getIt<CartCubit>()
                              .addToCart(product, 1)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Item added to cart"), // Static message
                              ),
                            );
                          });
                        },
                        label: const Text(
                          "Add to Cart", // Static text
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                    Consts.gapS,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
