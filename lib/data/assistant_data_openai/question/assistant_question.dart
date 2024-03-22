import 'package:json_annotation/json_annotation.dart';
import 'package:sgela_services/data/exam_link.dart';

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


  AssistantQuestion(
      this.fileName,
      this.sectionName,
      this.subSectionName,
      this.questionNumber,
      this.subQuestionNumber,
      this.questionText,
      this.subQuestionText,
      this.index,
      this.examLinkId,
      this.subjectId,
      this.assistantId,
      this.date,
      this.assistantName,
      this.examLinkTitle,
      this.subject);

  factory AssistantQuestion.fromJson(Map<String, dynamic> json) =>
      _$AssistantQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantQuestionToJson(this);
}
