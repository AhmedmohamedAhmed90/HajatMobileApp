import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/orders/models/order.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';
import 'package:heroicons/heroicons.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.item});
  final Order item;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.grey.shade50,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        Text(
                          "${(item).amountTotal.toStringAsFixed(2)} LYD",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
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
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          context.router.push(
                            OrderDetailsRoute(
                              order: item,
                            ),
                          );
                        },
                        child: const Text("Track Order"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
