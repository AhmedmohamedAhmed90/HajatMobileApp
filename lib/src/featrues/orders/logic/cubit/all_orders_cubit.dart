import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/orders/models/order.dart';
import 'package:hajat_mobile_app/src/services/api/api_service.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';

part 'all_orders_state.dart';
part 'all_orders_cubit.freezed.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  final api = getIt<ApiService>();
  AllOrdersCubit() : super(const AllOrdersState.initial()) {
    loadOrders();
  }

  void loadOrders() {
    emit(const AllOrdersState.loading());
    api.getOrders().then((response) {
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        getIt<Log>().info(response.data);
      } else {
        getIt<Log>().info(response.statusMessage);
        throw Exception(response.statusMessage);
      }
      List<Order> orders = [];
      for (var order in response.data) {
        orders.add(Order.fromJson(order));
      }
      emit(AllOrdersState.loaded(orders));
    }).catchError((e) {
      getIt<Log>().error(e.toString());
      emit(AllOrdersState.error(e.toString()));
    });
  }
}
