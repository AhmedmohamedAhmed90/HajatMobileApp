import 'package:bloc/bloc.dart';
import 'package:hajat_mobile_app/modules/Cart/models/cart_item.dart';
import 'package:hajat_mobile_app/services/storage/storage_service.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:get_it/get_it.dart';


import '../../../models/product_model.dart';
import 'cart_states.dart';


class CartCubit extends Cubit<CartState> {


    final StorageService storageService =  StorageService();
     List<CartItem> cart=[];

  CartCubit() : super(CartState.initial()) {
   getCart();
  }



  Future<void> getCart() async{

    emit(CartState.loading());

    try{
final cartJson= await storageService.getString('cart');
 if (cartJson != null) {
final List<dynamic> cartObjects=jsonDecode(cartJson);
cart=cartObjects.map((e)=>CartItem.fromJson(e)).toList();
 }

 emit(CartState.loaded(List.from(cart)));

    }catch(e){
     emit(CartState.error('Failed to get cart items: $e'));
    }

  }

  Future<void> addToCart(Product product, int quantity) async{
        emit(CartState.loading());
        try{

   int index=  cart.indexWhere((element)=>element.product.id==product.id);

   if(index!=-1){
    cart[index]=  cart[index].copyWith(quantity: cart[index].quantity+quantity);
    
   }else{
     cart.add(CartItem(product: product, quantity: quantity));
     emit(CartState.loaded(List.from(cart)));
           await _saveCart();
   }
        }catch(e){
          emit(CartState.error('Failed to add product to cart: $e'));
        }
  }

  Future<void> _saveCart() async{

   await storageService.setString('cart', jsonEncode(cart));

  }

  Future<void> removeFromCart(Product product, {bool removeOne = true})async {

    emit(CartState.loading());

    try{
      int index=cart.indexWhere((element)=>element.product.id==product.id);
if (index != -1) {
if(removeOne&&cart[index].quantity>1 ){
cart[index]=cart[index].copyWith(quantity: cart[index].quantity-1);


}
else{
  cart.removeAt(index);
}
}
  emit(CartState.loaded(List.from(cart)));
   await _saveCart();

    }catch(e){
      emit(CartState.error('Failed to remove product from cart: $e'));
    }
    
  }


Future<void> removeProductFromCart(Product product) async {
  emit(CartState.loading());

try{

    cart.removeWhere((element)=>element.product.id==product.id);
     emit(CartState.loaded(List.from(cart)));
   await _saveCart();
  
  
}catch(e){
  emit(CartState.error('Failed to remove product from cart: $e'));
}

}

 Future<void> clearCart() async {
    try {
      cart = [];
      emit(CartState.loaded(List.from(cart)));
      await _saveCart();
    } catch (e) {
      emit(CartState.error('Failed to clear cart: $e'));
    }
  }

  double getTotalAmount() {
    double total = 0.0;
    for (var item in cart) {
      //total += item.product.listPrice * item.quantity;
    }
    return total;
  }

}