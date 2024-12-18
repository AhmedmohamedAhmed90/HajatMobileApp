// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      dateOrder: json['dateOrder'] as String,
      amountTotal: (json['amountTotal'] as num).toDouble(),
      state: json['state'] as String,
      customStatus: json['customStatus'] as String,
      partnerId: json['partnerId'] as List<dynamic>?,
      orderLinesDetails: json['orderLinesDetails'] as List<dynamic>?,
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateOrder': instance.dateOrder,
      'amountTotal': instance.amountTotal,
      'state': instance.state,
      'customStatus': instance.customStatus,
      'partnerId': instance.partnerId,
      'orderLinesDetails': instance.orderLinesDetails,
    };
