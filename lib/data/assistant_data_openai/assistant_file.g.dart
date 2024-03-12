// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantFile _$AssistantFileFromJson(Map<String, dynamic> json) =>
    AssistantFile(
      id: json['id'] as String?,
      object: json['object'] as String?,
      bytes: json['bytes'] as int?,
      createdAt: json['created_at'] as int?,
      filename: json['filename'] as String?,
      purpose: json['purpose'] as String?,
      statusDetails: json['status_details'] as String?,
    );

Map<String, dynamic> _$AssistantFileToJson(AssistantFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'bytes': instance.bytes,
      'created_at': instance.createdAt,
      'filename': instance.filename,
      'purpose': instance.purpose,
      'status_details': instance.statusDetails,
    };
