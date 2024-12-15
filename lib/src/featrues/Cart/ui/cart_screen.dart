import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hajat_mobile_app/src/featrues/Cart/models/cart_item.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/Cart/logic/cart_states.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:heroicons/heroicons.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
       context.read<CartCubit>().getCart();
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<CartCubit, CartState>(
          bloc: getIt<CartCubit>(),
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (cart) {
                if (cart.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Cart is Empty',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add some items to your cart to get started',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final item = cart[index];
                          return CartItemCard(
                            item: item,
                          );
                        },
                      ),
                      Padding(
                        padding: Consts.paddingHM,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(),
                            Consts.gapVXL,
                            Text(
                              'Invoice',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Consts.gapVS,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total'),
                                Text(
                                  "\$${getIt<CartCubit>().getTotalAmount().toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            Consts.gapVXL,
                            Container(
                              margin: Consts.paddingVS,
                              child: ListTile(
                                title: Text(
                                  'Address',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                subtitle: const Text('Add your delivery address'),
                                leading: const HeroIcon(
                                  HeroIcons.informationCircle,
                                ),
                                trailing: TextButton(
                                  onPressed: () {
                                    print('Navigate to Add Address Screen');
                                  },
                                  child: const Text('Add Location'),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          Consts.borderRadiusM),
                                  side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                ),
                              ),
                            ),
                            Consts.gapVXL,
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  showAddressBottomSheet(context);
                                },
                                child: const Text('Confirm Order'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              orElse: () => const Center(
                  child: Text('No Data Available'),
              ),
            );
          },
        ),
      ),
    );
  }

  void showAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: Consts.paddingM,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeroIcon(
                        HeroIcons.mapPin,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Consts.gapVL,
                      Text(
                        'Please Add an Address',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        'Add your address to continue with the order',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Consts.gapVXL,
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            print('Navigate to Add Address Screen');
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add Address'),
                        ),
                      ),
                      Consts.gapVXL,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});
  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.borderRadiusM),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        margin: Consts.paddingHMVS,
        child: Padding(
          padding: Consts.paddingM,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: item.product.image,
                    fit: BoxFit.cover,
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
              Consts.gapHM,
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text("${item.quantity} piece"),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            getIt<CartCubit>()
                                .removeProductFromCart(item.product);
                          },
                        ),
                      ],
                    ),
                    Consts.gapVS,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                  getIt<CartCubit>()
                                      .removeFromCart(item.product);
                                },
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  getIt<CartCubit>().addToCart(item.product, 1);
                                },
                              ),
                            ],
                          ),
                        ),
                        Text("\$${(item).totalPrice.toStringAsFixed(2)}"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}