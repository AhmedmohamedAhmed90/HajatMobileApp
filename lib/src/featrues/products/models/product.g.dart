// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      listPrice: (json['list_price'] as num).toDouble(),
      qtyAvailable: (json['qty_available'] as num).toInt(),
      image: json['image'] as String,
      brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      productVariantId: (json['product_variant_id'] as num).toInt(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'list_price': instance.listPrice,
      'qty_available': instance.qtyAvailable,
      'image': instance.image,
      'brand': instance.brand.toJson(),
      'category': instance.category.toJson(),
      'product_variant_id': instance.productVariantId,
    };
