import 'package:json_annotation/json_annotation.dart';

part 'assistant_question.g.dart';

@JsonSerializable(explicitToJson: true)
class AssistantQuestion {
  String? fileName;
  String? sectionName;
  String? subSectionName;
  String? questionNumber;
  String? subQuestionNumber;
  String? questionText;
  List<String>? subQuestionText;
  int? index, examLinkId, subjectId;
  String? assistantId, date;
  String? assistantName, examLinkTitle, subject;


  AssistantQuestion({
      this.fileName,
      required this.sectionName,
      required this.subSectionName,
      required this.questionNumber,
      required this.subQuestionNumber,
      required this.questionText,
      required this.subQuestionText,
      required this.index,
      required this.examLinkId,
      required this.subjectId,
      required this.assistantId,
      required this.date,
      required this.assistantName,
      required this.examLinkTitle,
      required this.subject});

  factory AssistantQuestion.fromJson(Map<String, dynamic> json) =>
      _$AssistantQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantQuestionToJson(this);
}
