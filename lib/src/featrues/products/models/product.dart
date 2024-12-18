
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hajat/src/features/brands/models/brand.dart';

import '../../categories/models/category.dart';


part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  /*
    {
        "id": 3,
        "name": "Mars",
        "list_price": 3,
        "qty_available": 6,
        "image": "https://odoo.hajat.com.ly/api/product/3/image",
        "brand_name": "Mars",
        "category_name": "شوكولاتة"
    },
    }

   */
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
  

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
