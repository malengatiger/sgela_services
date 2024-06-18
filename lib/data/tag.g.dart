// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      (json['id'] as num?)?.toInt(),
      json['text'] as String?,
      (json['subjectId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'subjectId': instance.subjectId,
    };
