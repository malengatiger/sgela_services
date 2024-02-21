// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      json['id'] as int?,
      json['countryId'] as int?,
      json['organizationId'] as int?,
      json['userId'] as int?,
      json['payfastToken'] as String?,
      json['date'] as String?,
      json['pricing'] == null
          ? null
          : Pricing.fromJson(json['pricing'] as Map<String, dynamic>),
      json['subscriptionType'] as String?,
      json['activeFlag'] as bool?,
      json['organizationName'] as String?,
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'countryId': instance.countryId,
      'id': instance.id,
      'organizationId': instance.organizationId,
      'userId': instance.userId,
      'date': instance.date,
      'organizationName': instance.organizationName,
      'payfastToken': instance.payfastToken,
      'pricing': instance.pricing,
      'subscriptionType': instance.subscriptionType,
      'activeFlag': instance.activeFlag,
    };
