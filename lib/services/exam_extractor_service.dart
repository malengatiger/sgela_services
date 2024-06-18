import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/environment.dart';

import '../data/exam_page_content.dart';
import '../sgela_util/functions.dart';
import 'auth_service.dart';

class ExamExtractorService {
  final DioUtil dioUtil;
  final AuthService authService;

  ExamExtractorService(this.dioUtil, this.authService);
  static const mm = '🍎🍎🍎 ExamExtractorService 🔵';

  Future<List<ExamPageContent>> extractPageContentForExam(
      int examLinkId) async {
    var url = ChatbotEnvironment.getSkunkUrl();
    var mUrl = '${url}examPages/extractPageContentForExam';
    var token = await authService.getToken();
    if (token == null) {
      throw Exception('Failed to get auth token');
    }

    List<ExamPageContent> list = [];
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    pp('$mm ... calling $mUrl with headers: $headers for examLinkId: $examLinkId');
    try {
      Response res = await dioUtil.sendGetRequestWithHeaders(
          path: mUrl,
          queryParameters: {"examLinkId": examLinkId},
          headers: headers);
      pp('$mm ... response from backend; status: ${res.statusCode} \n${res.data}');
      if (res.statusCode == 200) {
        List jsonList = res.data;
        for (var value in jsonList) {
          list.add(ExamPageContent.fromJson(value));
        }
        pp('$mm ... exam pages extracted: ${list.length}');
      } else {
        throw Exception(
            'Failed to extract exam content: status ${res.statusCode} - ${res.data}');
      }
    } catch (e) {
      pp(e);
      throw Exception(
          'Failed to extract exam content: status $e');
    }
    return list;
  }
}
