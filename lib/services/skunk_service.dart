import 'dart:io';

import '../data/exam_page_content.dart';
import '../sgela_util/dio_util.dart';
import '../sgela_util/environment.dart';
import '../sgela_util/functions.dart';
import '../sgela_util/image_file_util.dart';
import 'local_data_service.dart';

class SkunkService {
  final DioUtil dioUtil;
  final LocalDataService localDataService;

  SkunkService(this.dioUtil, this.localDataService);
  static const mm = ' 🥦🥦🥦SkunkService 🥦 ';

  Future<List<ExamPageContent>> getExamPageContents(int examLinkId) async {
    List<ExamPageContent> examPageContents = [];

    var prefix = ChatbotEnvironment.getSkunkUrl();
    List res = await dioUtil.sendGetRequest(
        '${prefix}examPageContents/extractPageContentForExam',
        {'examLinkId': examLinkId});
    for (var mJson in res) {
      examPageContents.add(ExamPageContent.fromJson(mJson));
    }

    pp('$mm ... examPageContents: ${examPageContents.length}');
    for (var value in examPageContents) {
      if (value.pageImageUrl != null) {
        pp('$mm ... examPageContents: downloading exam page image ....');
        File file = await ImageFileUtil.downloadFile(value.pageImageUrl!, 'file${value.pageIndex}.png');
        value.uBytes = file.readAsBytesSync();
      }
      await localDataService.addExamPageContent(value);
    }

    return examPageContents;
  }
}
