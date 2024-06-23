import 'package:pretty_json/pretty_json.dart';
import 'package:sgela_services/data/summarized_exam.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/environment.dart';

import '../sgela_util/functions.dart';
import 'auth_service.dart';

class SummarizerService {
  final AuthService authService;
  final DioUtil dioUtil;

  SummarizerService({required this.authService, required this.dioUtil});

  static const mm = '🍎🍎🍎 SummarizerService 🍎🍎🍎';

  Future<SummarizedExam?> summarizePdf(int examLinkId, int weeks) async {
    var path = '${ChatbotEnvironment.getSkunkUrl()}pdf/summarizePdf';
    var token = await authService.getToken();
    if (token == null) {
      throw Exception('No auth token found');
    }
    SummarizedExam? exam;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    pp('$mm ... starting summarizer ... $path with headers: $headers');
    var start = DateTime.now();
    var resp = await dioUtil.sendGetRequestWithHeaders(
        path: path,
        queryParameters: {'examLinkId': examLinkId, 'weeks': weeks},
        headers: headers);
    var end = DateTime.now();

    pp('$mm summarizer done: 🥦statusCode: ${resp.statusCode} 🥦 '
        'elapsed: ${end.difference(start).inSeconds} seconds OR '
        '${end.difference(start).inMinutes} minutes ');

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      exam = SummarizedExam.fromJson(resp.data);
      pp(prettyJson(exam.toJson()));

    }

    return exam;
  }
}
