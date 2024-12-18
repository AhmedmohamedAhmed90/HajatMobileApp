import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/app/ui/widgets/error_card.dart';
import 'package:hajat_mobile_app/src/featrues/orders/logic/cubit/order_details_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/orders/models/order.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:heroicons/heroicons.dart';

@RoutePage()
class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        bloc: OrderDetailsCubit(
          order.id,
        ),
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(child: CircularProgressIndicator());
            },
            error: (message) {
              return Center(child: ErrorCard(message: message));
            },
            loaded: (item) {
              return Padding(
                padding: Consts.paddingM,
                child: Column(
                  children: [
                    // status
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text("${item.id}#"),
                          ],
                        ),
                        Container(
                          padding: Consts.paddingS,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(
                              Consts.borderRadiusS,
                            ),
                          ),
                          child: Text(
                            item.customStatus,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Consts.gapVS,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const HeroIcon(
                              HeroIcons.calendar,
                              size: Consts.iconSizeM,
                            ),
                            Consts.gapHS,
                            Text(
                              DateTime.parse(item.dateOrder).toIso8601String(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),

                    // invoice
                    const Divider(),
                    // Text(item.toString()),
                    if (item.orderLinesDetails != null)
                      Column(
                        children: item.orderLinesDetails!
                            .map(
                              (e) => ListTile(
                                title: Text(e["product_id"][1]),
                                subtitle: Text(
                                    "${e["price_unit"]} piece * ${e["product_uom_qty"]} LYD"),
                                trailing: Text("${e["price_subtotal"]} LYD"),
                              ),
                            )
                            .toList(),
                      ),
                    // show total amount
                    ListTile(
                      title: const Text("Total Amount"),
                      trailing: Text(
                        "${item.amountTotal} LYD",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),

                    // address
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
