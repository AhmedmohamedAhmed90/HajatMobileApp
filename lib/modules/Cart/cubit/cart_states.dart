import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/modules/Cart/models/cart_item.dart';

part 'cart_states.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.loaded(List<CartItem> cart) = _Loaded;
  const factory CartState.error(String message) = _Error;
}
