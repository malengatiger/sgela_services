import 'dart:async';

import 'package:sgela_services/data/exam_page_content.dart';

import '../data/exam_link.dart';
import '../data/subject.dart';

class ExamPageListener {

  final StreamController<List<ExamPageContent>> _examController = StreamController.broadcast();
  Stream<List<ExamPageContent>> get examPageStream =>  _examController.stream;

  void setExamPage(List<ExamPageContent> examPageContents) {
    _examController.sink.add(examPageContents);
  }
}

class SubjectListener {

  final StreamController<Subject> _subjectController = StreamController.broadcast();
  Stream<Subject> get subjectStream =>  _subjectController.stream;

  void setSubject(Subject subject) {
    _subjectController.sink.add(subject);
  }
}

class ExamLinkListener {

  final StreamController<ExamLink> _examLinkController = StreamController.broadcast();
  Stream<ExamLink> get examLinkStream =>  _examLinkController.stream;

  void setExamLink(ExamLink examLink) {
    _examLinkController.sink.add(examLink);
  }
}