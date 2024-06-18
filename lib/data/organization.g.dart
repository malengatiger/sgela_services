// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) => Organization(
      name: json['name'] as String?,
      email: json['email'] as String?,
      cellphone: json['cellphone'] as String?,
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      country: json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      adminUser: json['adminUser'] == null
          ? null
          : OrgUser.fromJson(json['adminUser'] as Map<String, dynamic>),
      logoUrl: json['logoUrl'] as String?,
      splashUrl: json['splashUrl'] as String?,
      activeFlag: json['activeFlag'] as bool?,
      tagLine: json['tagLine'] as String?,
    )
      ..websiteUrl = json['websiteUrl'] as String?
      ..brandingElapsedTimeInSeconds =
          (json['brandingElapsedTimeInSeconds'] as num?)?.toInt();

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'cellphone': instance.cellphone,
      'id': instance.id,
      'country': instance.country,
      'city': instance.city,
      'adminUser': instance.adminUser,
      'logoUrl': instance.logoUrl,
      'splashUrl': instance.splashUrl,
      'tagLine': instance.tagLine,
      'websiteUrl': instance.websiteUrl,
      'date': instance.date,
      'brandingElapsedTimeInSeconds': instance.brandingElapsedTimeInSeconds,
      'activeFlag': instance.activeFlag,
    };
