import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat_mobile_app/src/featrues/brands/models/brand.dart';
import '../../categories/models/category.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required double listPrice,
    required int qtyAvailable,
    required String image,
    required Brand brand,
    required Category category,
    required int productVariantId,
  }) = _Product;
  
  static int _parseId(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else if (value is int) {
      return value;
    }
    throw FormatException('Invalid ID format');
  }

  static double _parseDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    }
    throw FormatException('Invalid number format');
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson({
      ...json,
      'id': _parseId(json['id']),
      'listPrice': _parseDouble(json['list_price']),
      'qtyAvailable': _parseId(json['qty_available']),
      'productVariantId': _parseId(json['product_variant_id']),
    });
  }
}