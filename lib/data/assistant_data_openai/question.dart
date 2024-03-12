import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class OpenAIQuestion {
  String? assistantId, fileName;
  String? sectionName;
  String? questionNumber;
  String? questionText;
  List<String>? subQuestionText;
  int? index;
  int? examLinkId, subjectId;
  String? date, subject, examTitle, fileUrl;

  OpenAIQuestion(
      {required this.assistantId,
      required this.fileName,
      required this.sectionName,
      required this.questionNumber,
      required this.questionText,
      required this.subQuestionText,
      required this.index,
      required this.examLinkId,
      required this.subjectId,
      required this.date,
      required this.fileUrl,
      required this.examTitle,
      required this.subject});

  factory OpenAIQuestion.fromJson(Map<String, dynamic> json) =>
      _$OpenAIQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$OpenAIQuestionToJson(this);
}
