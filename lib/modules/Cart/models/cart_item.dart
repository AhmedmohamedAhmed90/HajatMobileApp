
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/models/product_model.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  
  const factory CartItem({
    required Product product,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  
  //double get totalPrice => product.listPrice * quantity;
}