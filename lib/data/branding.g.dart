// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branding _$BrandingFromJson(Map<String, dynamic> json) => Branding(
      organizationId: (json['organizationId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      logoUrl: json['logoUrl'] as String?,
      splashUrl: json['splashUrl'] as String?,
      tagLine: json['tagLine'] as String?,
      organizationName: json['organizationName'] as String?,
      organizationUrl: json['organizationUrl'] as String?,
      splashTimeInSeconds: (json['splashTimeInSeconds'] as num?)?.toInt(),
      colorIndex: (json['colorIndex'] as num?)?.toInt(),
      boxFit: (json['boxFit'] as num?)?.toInt(),
      activeFlag: json['activeFlag'] as bool?,
    );

Map<String, dynamic> _$BrandingToJson(Branding instance) => <String, dynamic>{
      'organizationId': instance.organizationId,
      'id': instance.id,
      'splashTimeInSeconds': instance.splashTimeInSeconds,
      'colorIndex': instance.colorIndex,
      'date': instance.date,
      'logoUrl': instance.logoUrl,
      'splashUrl': instance.splashUrl,
      'tagLine': instance.tagLine,
      'organizationName': instance.organizationName,
      'organizationUrl': instance.organizationUrl,
      'activeFlag': instance.activeFlag,
      'boxFit': instance.boxFit,
    };
