// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryState _$CountryStateFromJson(Map<String, dynamic> json) => CountryState(
      (json['id'] as num?)?.toInt(),
      json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
    )..name = json['name'] as String?;

Map<String, dynamic> _$CountryStateToJson(CountryState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };
