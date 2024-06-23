// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summarized_exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummarizedExam _$SummarizedExamFromJson(Map<String, dynamic> json) =>
    SummarizedExam(
      (json['id'] as num).toInt(),
      concepts: json['concepts'] as String?,
      lessonPlan: json['lessonPlan'] as String?,
      pdfUri: json['pdfUri'] as String?,
      agentResponseUri: json['agentResponseUri'] as String?,
      agentResponseUrl: json['agentResponseUrl'] as String?,
      examLinkId: (json['examLinkId'] as num?)?.toInt(),
      date: json['date'] as String?,
      firebaseUserId: json['firebaseUserId'],
      answers: json['answers'] as String?,
      totalTokens: (json['totalTokens'] as num?)?.toInt(),
      promptTokens: (json['promptTokens'] as num?)?.toInt(),
      candidatesTokens: (json['candidatesTokens'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SummarizedExamToJson(SummarizedExam instance) =>
    <String, dynamic>{
      'concepts': instance.concepts,
      'lessonPlan': instance.lessonPlan,
      'pdfUri': instance.pdfUri,
      'agentResponseUri': instance.agentResponseUri,
      'agentResponseUrl': instance.agentResponseUrl,
      'examLinkId': instance.examLinkId,
      'date': instance.date,
      'firebaseUserId': instance.firebaseUserId,
      'answers': instance.answers,
      'totalTokens': instance.totalTokens,
      'promptTokens': instance.promptTokens,
      'candidatesTokens': instance.candidatesTokens,
      'id': instance.id,
    };
