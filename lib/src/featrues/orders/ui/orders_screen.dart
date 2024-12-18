import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/empty_widget.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/error_screen.dart';
import 'package:hajat_mobile_app/src/featrues/orders/logic/cubit/all_orders_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/orders/ui/order_item.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

@RoutePage()
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllOrdersCubit, AllOrdersState>(
        bloc: getIt<AllOrdersCubit>(),
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(child: CircularProgressIndicator());
            },
            loaded: (orders) {
              if (orders.isEmpty) {
                return const EmptyWidget(
                  title: "No Orders",
                  message: "You have not placed any orders yet.",
                  image: "assets/images/empty-orders.png",
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  getIt<AllOrdersCubit>().loadOrders();
                },
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return OrderItem(item: orders[index]);
                  },
                ),
              );
            },
            error: (message) {
              return ErrorScreen(message: message);
            },
          );
        },
      ),
    );
  }
}
