
import 'package:json_annotation/json_annotation.dart';
import 'package:sgela_services/data/subject.dart';

import 'exam_document.dart';

part 'exam_link.g.dart';

@JsonSerializable()
class ExamLink {
  String? title;
  String? link;
  int? id;
  Subject? subject;
  ExamDocument?  examDocument;
  String? pageImageZipUrl;
  String? documentTitle;


  ExamLink(this.title, this.link, this.id, this.subject, this.examDocument,
      this.pageImageZipUrl, this.documentTitle);

  factory ExamLink.fromJson(Map<String, dynamic> json) =>
      _$ExamLinkFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$ExamLinkToJson(this);

    return data;
  }


}
