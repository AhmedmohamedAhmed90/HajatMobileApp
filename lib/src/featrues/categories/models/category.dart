import 'package:freezed_annotation/freezed_annotation.dart';


part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {

  const factory Category({
    required int id,
    required String name,
    required String? image,
 
  }) = _Category;

  /// Connect the generated function to the `fromJson` factory.
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}