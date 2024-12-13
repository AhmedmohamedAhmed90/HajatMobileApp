import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../models/product_model.dart';
import 'cart_states.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(cart: [])) {
    loadCart();
  }

  void addToCart(Product product) {
    final existingProduct = state.cart.firstWhere(
      (p) => p.id == product.id,
      orElse: () => product,
    );

    if (existingProduct != product) {
      existingProduct.quantity += 1;
    } else {
      state.cart.add(product);
    }

    saveCart();
    emit(CartState(cart: List.from(state.cart)));
  }

  void removeFromCart(Product product) {
    state.cart.removeWhere((p) => p.id == product.id);
    saveCart();
    emit(CartState(cart: List.from(state.cart)));
  }

  void increaseQuantity(Product product) {
    final existingProduct = state.cart.firstWhere((p) => p.id == product.id);
    existingProduct.quantity += 1;
    saveCart();
    emit(CartState(cart: List.from(state.cart)));
  }

  void decreaseQuantity(Product product) {
    final existingProduct = state.cart.firstWhere((p) => p.id == product.id);
    if (existingProduct.quantity > 1) {
      existingProduct.quantity -= 1;
      saveCart();
      emit(CartState(cart: List.from(state.cart)));
    }
  }

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> cartList = json.decode(cartJson);
      final cart = cartList.map((e) => Product.fromJson(e)).toList();
      emit(CartState(cart: cart));
    }
  }

  void saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(state.cart.map((e) => e.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }
}
