
import 'package:json_annotation/json_annotation.dart';
import 'package:sgela_services/data/subject.dart';

import 'exam_document.dart';

part 'exam_link.g.dart';

@JsonSerializable()
class ExamLink {
  String? title;
  String? link;
  int? id;
  String? subject;
  int?  examDocumentId, subjectId, year;
  String? pageImageZipUrl, examPdfUrl, zippedPaperUrl;
  String? documentTitle;
  bool? isMemo;


  ExamLink(
      this.title,
      this.link,
      this.id,
      this.subject,
      this.examDocumentId,
      this.subjectId,
      this.year,
      this.pageImageZipUrl,
      this.examPdfUrl,
      this.zippedPaperUrl,
      this.documentTitle,
      this.isMemo);

  factory ExamLink.fromJson(Map<String, dynamic> json) =>
      _$ExamLinkFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$ExamLinkToJson(this);

    return data;
  }


}
