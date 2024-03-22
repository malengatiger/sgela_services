// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantQuestion _$AssistantQuestionFromJson(Map<String, dynamic> json) =>
    AssistantQuestion(
      json['fileName'] as String?,
      json['sectionName'] as String?,
      json['subSectionName'] as String?,
      json['questionNumber'] as String?,
      json['subQuestionNumber'] as String?,
      json['questionText'] as String?,
      (json['subQuestionText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['index'] as int?,
      json['examLinkId'] as int?,
      json['subjectId'] as int?,
      json['assistantId'] as String?,
      json['date'] as String?,
      json['assistantName'] as String?,
      json['examLinkTitle'] as String?,
      json['subject'] as String?,
    );

Map<String, dynamic> _$AssistantQuestionToJson(AssistantQuestion instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'sectionName': instance.sectionName,
      'subSectionName': instance.subSectionName,
      'questionNumber': instance.questionNumber,
      'subQuestionNumber': instance.subQuestionNumber,
      'questionText': instance.questionText,
      'subQuestionText': instance.subQuestionText,
      'index': instance.index,
      'examLinkId': instance.examLinkId,
      'subjectId': instance.subjectId,
      'assistantId': instance.assistantId,
      'date': instance.date,
      'assistantName': instance.assistantName,
      'examLinkTitle': instance.examLinkTitle,
      'subject': instance.subject,
    };
