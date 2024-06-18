// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantQuestion _$AssistantQuestionFromJson(Map<String, dynamic> json) =>
    AssistantQuestion(
      fileName: json['fileName'] as String?,
      sectionName: json['sectionName'] as String?,
      subSectionName: json['subSectionName'] as String?,
      questionNumber: json['questionNumber'] as String?,
      subQuestionNumber: json['subQuestionNumber'] as String?,
      questionText: json['questionText'] as String?,
      subQuestionText: (json['subQuestionText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      index: (json['index'] as num?)?.toInt(),
      examLinkId: (json['examLinkId'] as num?)?.toInt(),
      subjectId: (json['subjectId'] as num?)?.toInt(),
      assistantId: json['assistantId'] as String?,
      date: json['date'] as String?,
      assistantName: json['assistantName'] as String?,
      examLinkTitle: json['examLinkTitle'] as String?,
      subject: json['subject'] as String?,
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
