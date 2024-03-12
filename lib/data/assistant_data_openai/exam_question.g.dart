// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamQuestion _$ExamQuestionFromJson(Map<String, dynamic> json) => ExamQuestion(
      fileName: json['fileName'] as String?,
      section: json['section'] as String?,
      subSection: json['subSection'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamQuestionToJson(ExamQuestion instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'section': instance.section,
      'subSection': instance.subSection,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      questionNumber: json['questionNumber'] as String?,
      questionText: json['questionText'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionNumber': instance.questionNumber,
      'questionText': instance.questionText,
    };
