import 'package:json_annotation/json_annotation.dart';

part 'exam_question.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamQuestion {
  final String? fileName;
  final String? section;
  final String? subSection;
  final List<Question>? questions;

  const ExamQuestion({
    this.fileName,
    this.section,
    this.subSection,
    this.questions,
  });

  factory ExamQuestion.fromJson(Map<String, dynamic> json) =>
      _$ExamQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$ExamQuestionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Question {
  final String? questionNumber;
  final String? questionText;

  const Question({
    this.questionNumber,
    this.questionText,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
