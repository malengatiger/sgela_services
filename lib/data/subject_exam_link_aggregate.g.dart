// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_exam_link_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectExamLinkAggregate _$SubjectExamLinkAggregateFromJson(
        Map<String, dynamic> json) =>
    SubjectExamLinkAggregate(
      subjectId: (json['subjectId'] as num?)?.toInt(),
      title: json['title'] as String?,
      examLinks: (json['examLinks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubjectExamLinkAggregateToJson(
        SubjectExamLinkAggregate instance) =>
    <String, dynamic>{
      'subjectId': instance.subjectId,
      'title': instance.title,
      'examLinks': instance.examLinks,
    };
