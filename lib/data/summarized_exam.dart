import 'package:json_annotation/json_annotation.dart';

part 'summarized_exam.g.dart';

@JsonSerializable(explicitToJson: true)
class SummarizedExam {
  final String? concepts;
  final String? lessonPlan;
  final String? pdfUri;
  final String? agentResponseUri;
  final String? agentResponseUrl;
  final int? examLinkId;
  final String? date;
  final dynamic firebaseUserId;
  final String? answers;
  final int? totalTokens;
  final int? promptTokens;
  final int? candidatesTokens;
  final int id;

  const SummarizedExam(this.id, {
    this.concepts,
    this.lessonPlan,
    this.pdfUri,
    this.agentResponseUri,
    this.agentResponseUrl,
    this.examLinkId,
    this.date,
    this.firebaseUserId,
    this.answers,
    this.totalTokens,
    this.promptTokens,
    this.candidatesTokens,
  });

  factory SummarizedExam.fromJson(Map<String, dynamic> json) =>
      _$SummarizedExamFromJson(json);

  Map<String, dynamic> toJson() => _$SummarizedExamToJson(this);
}
