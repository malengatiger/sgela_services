// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamDocument _$ExamDocumentFromJson(Map<String, dynamic> json) => ExamDocument(
      json['title'] as String?,
      json['link'] as String?,
      (json['id'] as num?)?.toInt(),
      (json['year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ExamDocumentToJson(ExamDocument instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'id': instance.id,
      'year': instance.year,
    };
