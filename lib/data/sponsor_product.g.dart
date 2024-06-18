// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsorProduct _$SponsorProductFromJson(Map<String, dynamic> json) =>
    SponsorProduct(
      (json['amountPerSponsoree'] as num?)?.toDouble(),
      json['title'] as String?,
      (json['periodInMonths'] as num?)?.toInt(),
      json['currency'] as String?,
      json['countryName'] as String?,
      json['date'] as String?,
      (json['id'] as num?)?.toInt(),
      json['activeFlag'] as bool?,
      (json['studentsSponsored'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SponsorProductToJson(SponsorProduct instance) =>
    <String, dynamic>{
      'amountPerSponsoree': instance.amountPerSponsoree,
      'title': instance.title,
      'periodInMonths': instance.periodInMonths,
      'currency': instance.currency,
      'countryName': instance.countryName,
      'date': instance.date,
      'id': instance.id,
      'activeFlag': instance.activeFlag,
      'studentsSponsored': instance.studentsSponsored,
    };

OrganizationSponsorPaymentType _$OrganizationSponsorPaymentTypeFromJson(
        Map<String, dynamic> json) =>
    OrganizationSponsorPaymentType(
      (json['organizationId'] as num?)?.toInt(),
      json['organizationName'] as String?,
      json['sponsorPaymentType'] == null
          ? null
          : SponsorProduct.fromJson(
              json['sponsorPaymentType'] as Map<String, dynamic>),
      json['date'] as String?,
    );

Map<String, dynamic> _$OrganizationSponsorPaymentTypeToJson(
        OrganizationSponsorPaymentType instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
      'sponsorPaymentType': instance.sponsorPaymentType,
      'date': instance.date,
    };
