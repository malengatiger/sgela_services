// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      created: (json['created'] as num?)?.toInt(),
      ownedBy: json['owned_by'] as String?,
    );

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'created': instance.created,
      'owned_by': instance.ownedBy,
    };
