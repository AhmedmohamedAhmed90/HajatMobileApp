import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cart_cubit.dart';
import 'cubit/cart_states.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }

          return ListView.builder(
            itemCount: state.cart.length,
            itemBuilder: (context, index) {
              final product = state.cart[index];
              return ListTile(
                leading: Image.asset(product.imageUrl, height: 50, width: 50, fit: BoxFit.cover),
                title: Text(product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quantity: ${product.quantity}'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context.read<CartCubit>().decreaseQuantity(product);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            context.read<CartCubit>().increaseQuantity(product);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                onTap: () {
                  context.read<CartCubit>().removeFromCart(product);
                },
              );
            },
          );
        },
      ),
    );
  }
}
