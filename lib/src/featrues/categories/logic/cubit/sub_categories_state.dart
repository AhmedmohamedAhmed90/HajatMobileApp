part of 'sub_categories_cubit.dart';

@freezed
class SubCategoriesState with _$SubCategoriesState {
  const factory SubCategoriesState.initial() = _Initial;
  const factory SubCategoriesState.loading() = _Loading;
  const factory SubCategoriesState.loaded(List<Category> categories) = _Loaded;
  const factory SubCategoriesState.error(String message) = _Error;
}
