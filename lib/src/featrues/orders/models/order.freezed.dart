// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get dateOrder => throw _privateConstructorUsedError;
  double get amountTotal => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get customStatus => throw _privateConstructorUsedError;
  List<dynamic>? get partnerId => throw _privateConstructorUsedError;
  List<dynamic>? get orderLinesDetails => throw _privateConstructorUsedError;

  /// Serializes this Order to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {int id,
      String name,
      String dateOrder,
      double amountTotal,
      String state,
      String customStatus,
      List<dynamic>? partnerId,
      List<dynamic>? orderLinesDetails});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOrder = null,
    Object? amountTotal = null,
    Object? state = null,
    Object? customStatus = null,
    Object? partnerId = freezed,
    Object? orderLinesDetails = freezed,
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
      dateOrder: null == dateOrder
          ? _value.dateOrder
          : dateOrder // ignore: cast_nullable_to_non_nullable
              as String,
      amountTotal: null == amountTotal
          ? _value.amountTotal
          : amountTotal // ignore: cast_nullable_to_non_nullable
              as double,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      customStatus: null == customStatus
          ? _value.customStatus
          : customStatus // ignore: cast_nullable_to_non_nullable
              as String,
      partnerId: freezed == partnerId
          ? _value.partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      orderLinesDetails: freezed == orderLinesDetails
          ? _value.orderLinesDetails
          : orderLinesDetails // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String dateOrder,
      double amountTotal,
      String state,
      String customStatus,
      List<dynamic>? partnerId,
      List<dynamic>? orderLinesDetails});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? dateOrder = null,
    Object? amountTotal = null,
    Object? state = null,
    Object? customStatus = null,
    Object? partnerId = freezed,
    Object? orderLinesDetails = freezed,
  }) {
    return _then(_$OrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateOrder: null == dateOrder
          ? _value.dateOrder
          : dateOrder // ignore: cast_nullable_to_non_nullable
              as String,
      amountTotal: null == amountTotal
          ? _value.amountTotal
          : amountTotal // ignore: cast_nullable_to_non_nullable
              as double,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      customStatus: null == customStatus
          ? _value.customStatus
          : customStatus // ignore: cast_nullable_to_non_nullable
              as String,
      partnerId: freezed == partnerId
          ? _value._partnerId
          : partnerId // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      orderLinesDetails: freezed == orderLinesDetails
          ? _value._orderLinesDetails
          : orderLinesDetails // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {required this.id,
      required this.name,
      required this.dateOrder,
      required this.amountTotal,
      required this.state,
      required this.customStatus,
      final List<dynamic>? partnerId,
      final List<dynamic>? orderLinesDetails})
      : _partnerId = partnerId,
        _orderLinesDetails = orderLinesDetails;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String dateOrder;
  @override
  final double amountTotal;
  @override
  final String state;
  @override
  final String customStatus;
  final List<dynamic>? _partnerId;
  @override
  List<dynamic>? get partnerId {
    final value = _partnerId;
    if (value == null) return null;
    if (_partnerId is EqualUnmodifiableListView) return _partnerId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _orderLinesDetails;
  @override
  List<dynamic>? get orderLinesDetails {
    final value = _orderLinesDetails;
    if (value == null) return null;
    if (_orderLinesDetails is EqualUnmodifiableListView)
      return _orderLinesDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Order(id: $id, name: $name, dateOrder: $dateOrder, amountTotal: $amountTotal, state: $state, customStatus: $customStatus, partnerId: $partnerId, orderLinesDetails: $orderLinesDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateOrder, dateOrder) ||
                other.dateOrder == dateOrder) &&
            (identical(other.amountTotal, amountTotal) ||
                other.amountTotal == amountTotal) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.customStatus, customStatus) ||
                other.customStatus == customStatus) &&
            const DeepCollectionEquality()
                .equals(other._partnerId, _partnerId) &&
            const DeepCollectionEquality()
                .equals(other._orderLinesDetails, _orderLinesDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      dateOrder,
      amountTotal,
      state,
      customStatus,
      const DeepCollectionEquality().hash(_partnerId),
      const DeepCollectionEquality().hash(_orderLinesDetails));

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {required final int id,
      required final String name,
      required final String dateOrder,
      required final double amountTotal,
      required final String state,
      required final String customStatus,
      final List<dynamic>? partnerId,
      final List<dynamic>? orderLinesDetails}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get dateOrder;
  @override
  double get amountTotal;
  @override
  String get state;
  @override
  String get customStatus;
  @override
  List<dynamic>? get partnerId;
  @override
  List<dynamic>? get orderLinesDetails;

  /// Create a copy of Order
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
