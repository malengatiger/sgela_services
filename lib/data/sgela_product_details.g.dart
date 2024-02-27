// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sgela_product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SgelaProductDetails _$SgelaProductDetailsFromJson(Map<String, dynamic> json) =>
    SgelaProductDetails(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      rawPrice: (json['rawPrice'] as num?)?.toDouble(),
      currencyCode: json['currencyCode'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      organizationId: json['organizationId'] as int?,
      organizationName: json['organizationName'] as String?,
      isOneTime: json['isOneTime'] as bool?,
      isAppleStore: json['isAppleStore'] as bool?,
      productId: json['productId'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$SgelaProductDetailsToJson(
        SgelaProductDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'productId': instance.productId,
      'title': instance.title,
      'description': instance.description,
      'organizationName': instance.organizationName,
      'price': instance.price,
      'rawPrice': instance.rawPrice,
      'currencyCode': instance.currencyCode,
      'date': instance.date,
      'currencySymbol': instance.currencySymbol,
      'isOneTime': instance.isOneTime,
      'isAppleStore': instance.isAppleStore,
    };
