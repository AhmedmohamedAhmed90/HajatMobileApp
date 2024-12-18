part of 'brands_cubit.dart';

@freezed
class BrandsState with _$BrandsState {
  const factory BrandsState.initial() = _Initial;
  const factory BrandsState.loading() = _Loading;
  const factory BrandsState.loaded(List<Brand> brands) = _Loaded;
  const factory BrandsState.error(String message) = _Error;
}
