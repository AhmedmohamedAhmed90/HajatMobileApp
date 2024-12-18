// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      listPrice: (json['listPrice'] as num).toDouble(),
      qtyAvailable: (json['qtyAvailable'] as num).toInt(),
      image: json['image'] as String,
      brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      productVariantId: (json['productVariantId'] as num).toInt(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'listPrice': instance.listPrice,
      'qtyAvailable': instance.qtyAvailable,
      'image': instance.image,
      'brand': instance.brand,
      'category': instance.category,
      'productVariantId': instance.productVariantId,
    };
