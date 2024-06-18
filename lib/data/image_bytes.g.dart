// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_bytes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageBytes _$ImageBytesFromJson(Map<String, dynamic> json) => ImageBytes(
      (json['examLinkId'] as num?)?.toInt(),
      (json['id'] as num?)?.toInt(),
      (json['bytes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      (json['imageIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageBytesToJson(ImageBytes instance) =>
    <String, dynamic>{
      'examLinkId': instance.examLinkId,
      'id': instance.id,
      'bytes': instance.bytes,
      'imageIndex': instance.imageIndex,
    };
