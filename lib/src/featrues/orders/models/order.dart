import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required int id,
    required String name,
    required String dateOrder,
    required double amountTotal,
    required String state,
    required String customStatus,
    List<dynamic>? partnerId,
    List<dynamic>? orderLinesDetails,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
