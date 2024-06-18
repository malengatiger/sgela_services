// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_page_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamPageImage _$ExamPageImageFromJson(Map<String, dynamic> json) =>
    ExamPageImage(
      examLinkId: (json['examLinkId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      bytes: (json['bytes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      pageIndex: (json['pageIndex'] as num?)?.toInt(),
      mimeType: json['mimeType'] as String?,
    );

Map<String, dynamic> _$ExamPageImageToJson(ExamPageImage instance) =>
    <String, dynamic>{
      'examLinkId': instance.examLinkId,
      'id': instance.id,
      'bytes': instance.bytes,
      'pageIndex': instance.pageIndex,
      'mimeType': instance.mimeType,
    };
