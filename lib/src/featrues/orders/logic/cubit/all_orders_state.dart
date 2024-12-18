part of 'all_orders_cubit.dart';

@freezed
class AllOrdersState with _$AllOrdersState {
  const factory AllOrdersState.initial() = _Initial;
  const factory AllOrdersState.loading() = _Loading;
  const factory AllOrdersState.loaded(List<Order> orders) = _Loaded;
  const factory AllOrdersState.error(String message) = _Error;
}
