// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAIQuestion _$OpenAIQuestionFromJson(Map<String, dynamic> json) =>
    OpenAIQuestion(
      assistantId: json['assistantId'] as String?,
      fileName: json['fileName'] as String?,
      sectionName: json['sectionName'] as String?,
      questionNumber: json['questionNumber'] as String?,
      questionText: json['questionText'] as String?,
      subQuestionText: (json['subQuestionText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      index: json['index'] as int?,
      examLinkId: json['examLinkId'] as int?,
      subjectId: json['subjectId'] as int?,
      date: json['date'] as String?,
      fileUrl: json['fileUrl'] as String?,
      examTitle: json['examTitle'] as String?,
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$OpenAIQuestionToJson(OpenAIQuestion instance) =>
    <String, dynamic>{
      'assistantId': instance.assistantId,
      'fileName': instance.fileName,
      'sectionName': instance.sectionName,
      'questionNumber': instance.questionNumber,
      'questionText': instance.questionText,
      'subQuestionText': instance.subQuestionText,
      'index': instance.index,
      'examLinkId': instance.examLinkId,
      'subjectId': instance.subjectId,
      'date': instance.date,
      'subject': instance.subject,
      'examTitle': instance.examTitle,
      'fileUrl': instance.fileUrl,
    };
