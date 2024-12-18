import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/featrues/orders/models/order.dart';

part 'order_details_state.dart';
part 'order_details_cubit.freezed.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final api = getIt<ApiService>();
  OrderDetailsCubit(this.id) : super(const OrderDetailsState.initial()) {
    loadOrderDetails(id);
  }
  final int id;

  void loadOrderDetails(int orderId) async {
    try {
      emit(const OrderDetailsState.loading());
      var response = await api.getOrderDetails(orderId);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(response.data);
      } else {
        getIt<Log>().info(response.statusMessage);
        throw Exception(response.statusMessage);
      }
      var order = Order.fromJson(response.data);
      emit(OrderDetailsState.loaded(order));
    } catch (e) {
      getIt<Log>().error(e.toString());
      emit(OrderDetailsState.error(e.toString()));
    }
  }
}
