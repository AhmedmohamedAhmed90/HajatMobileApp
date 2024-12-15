// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get listPrice => throw _privateConstructorUsedError;
  int get qtyAvailable => throw _privateConstructorUsedError;
  String get image =>
      throw _privateConstructorUsedError; // required Brand brand,
// required Category category,
  int get productVariantId => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {int id,
      String name,
      double listPrice,
      int qtyAvailable,
      String image,
      int productVariantId});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? listPrice = null,
    Object? qtyAvailable = null,
    Object? image = null,
    Object? productVariantId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      listPrice: null == listPrice
          ? _value.listPrice
          : listPrice // ignore: cast_nullable_to_non_nullable
              as double,
      qtyAvailable: null == qtyAvailable
          ? _value.qtyAvailable
          : qtyAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      productVariantId: null == productVariantId
          ? _value.productVariantId
          : productVariantId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      double listPrice,
      int qtyAvailable,
      String image,
      int productVariantId});
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? listPrice = null,
    Object? qtyAvailable = null,
    Object? image = null,
    Object? productVariantId = null,
  }) {
    return _then(_$ProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      listPrice: null == listPrice
          ? _value.listPrice
          : listPrice // ignore: cast_nullable_to_non_nullable
              as double,
      qtyAvailable: null == qtyAvailable
          ? _value.qtyAvailable
          : qtyAvailable // ignore: cast_nullable_to_non_nullable
              as int,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      productVariantId: null == productVariantId
          ? _value.productVariantId
          : productVariantId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {required this.id,
      required this.name,
      required this.listPrice,
      required this.qtyAvailable,
      required this.image,
      required this.productVariantId});

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final double listPrice;
  @override
  final int qtyAvailable;
  @override
  final String image;
// required Brand brand,
// required Category category,
  @override
  final int productVariantId;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, listPrice: $listPrice, qtyAvailable: $qtyAvailable, image: $image, productVariantId: $productVariantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.listPrice, listPrice) ||
                other.listPrice == listPrice) &&
            (identical(other.qtyAvailable, qtyAvailable) ||
                other.qtyAvailable == qtyAvailable) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.productVariantId, productVariantId) ||
                other.productVariantId == productVariantId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, listPrice, qtyAvailable, image, productVariantId);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {required final int id,
      required final String name,
      required final double listPrice,
      required final int qtyAvailable,
      required final String image,
      required final int productVariantId}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  double get listPrice;
  @override
  int get qtyAvailable;
  @override
  String get image; // required Brand brand,
// required Category category,
  @override
  int get productVariantId;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
