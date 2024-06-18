// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamLink _$ExamLinkFromJson(Map<String, dynamic> json) => ExamLink(
      json['title'] as String?,
      json['link'] as String?,
      (json['id'] as num?)?.toInt(),
      json['subject'] as String?,
      (json['examDocumentId'] as num?)?.toInt(),
      (json['subjectId'] as num?)?.toInt(),
      (json['year'] as num?)?.toInt(),
      json['pageImageZipUrl'] as String?,
      json['examPdfUrl'] as String?,
      json['zippedPaperUrl'] as String?,
      json['documentTitle'] as String?,
      json['isMemo'] as bool?,
    );

Map<String, dynamic> _$ExamLinkToJson(ExamLink instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'id': instance.id,
      'subject': instance.subject,
      'examDocumentId': instance.examDocumentId,
      'subjectId': instance.subjectId,
      'year': instance.year,
      'pageImageZipUrl': instance.pageImageZipUrl,
      'examPdfUrl': instance.examPdfUrl,
      'zippedPaperUrl': instance.zippedPaperUrl,
      'documentTitle': instance.documentTitle,
      'isMemo': instance.isMemo,
    };
