import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../services/local_data_service.dart';
import 'environment.dart';
import 'functions.dart';
import 'image_file_util.dart';

class DioUtil {
  final Dio dio;
  static const mm = '🥬🥬🥬🥬 DioUtil 🥬';
  final LocalDataService localDataService;

  DioUtil(this.dio, this.localDataService);

  static const urlPrefix =
      'https://generativelanguage.googleapis.com/v1beta/models/';

  Future countGeminiTokens(
      {required String prompt,
      required List<File> files,
      required String model}) async {
    try {
      List<MultipartFile> mFiles = [];
      for (var file in files) {
        String mimeType = ImageFileUtil.getMimeType(file);
        mFiles.add(await MultipartFile.fromFile(file.path,
            contentType: MediaType.parse(mimeType)));
      }
      FormData formData = FormData.fromMap({
        'prompt': prompt,
        'model': model,
        'mimeType': 'image/png',
        'files': mFiles,
      });
      var url =
          '${ChatbotEnvironment.getGeminiUrl()}textImage/countGeminiTokens';
      pp('$mm ..... sending url: $url');
      final response = await dio.post(url, data: formData);
      pp('$mm response: ${response.statusCode} data:${response.data}');
      return response.data;
    } catch (e, s) {
      pp('$mm 👿👿👿 ERROR: 🍎🍎$e 🍎🍎 STACKTRACE: $s 👿');
    }
    throw Exception('👿👿👿Failed to send tokensUsed');
  }

  Future<Response> sendGetRequestWithHeaders(
      {required String path,
      required Map<String, dynamic> queryParameters,
      required dynamic headers}) async {
    pp('$mm Dio sendGetRequestWithHeaders ...: 🍎🍎🍎 path: $path 🍎🍎');
    try {
      Response response;
      // The below request is the same as above.
      response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers, responseType: ResponseType.json),
      );

      pp('$mm Dio network response: 🥬🥬🥬🥬🥬🥬 status code: ${response.statusCode}');
      return response;
    } catch (e) {
      pp('$mm Dio network response: 👿👿👿👿 ERROR: $e');
      pp(e);
      rethrow;
    }
  }

  Future<Response> sendGetRequest(
      {required String path,
      required Map<String, dynamic> params}) async {
    pp('$mm Dio starting ...: 🍎🍎🍎 path: $path 🍎 '
        '\n 🍎params: $params 🍎');
    try {
      Response response;
      response = await dio
          .get(
        path,
        queryParameters: params,
        options: Options(responseType: ResponseType.json),
      )
          .catchError((error, stackTrace) {
        pp('$mm Error occurred during the GET request: '
            '👿 $error 👿\n 👿$stackTrace 👿');
      });

      pp('$mm Dio network response: 🥬🥬🥬🥬🥬🥬 status code: ${response.statusCode}');
      return response;
    } catch (e) {
      pp('$mm Dio network response: 👿👿👿👿 ERROR: $e');
      pp(e);
      rethrow;
    }
  }

  Future<Response> sendPostRequest({
    required String path,
    required dynamic body,
    dynamic headers,
  }) async {
    pp('$mm Dio sendPostRequest ...: 🍎🍎🍎 path: $path 🍎🍎');
    try {
      Response response = await dio
          .post(
        path,
        data: body,
        options: Options(responseType: ResponseType.json, headers: headers),
        onReceiveProgress: (count, total) {
          pp('$mm onReceiveProgress: count: $count total: $total');
        },
        onSendProgress: (count, total) {
          pp('$mm onSendProgress: count: $count total: $total');
        },
      )
          .timeout(const Duration(seconds: 300));

      pp('$mm .... network POST response, 💚status code: ${response.statusCode} 💚💚 $path');
      return response;
    } catch (e, stackTrace) {
      pp('$mm .... network POST error response, '
          '👿👿👿👿 $e 👿👿👿👿');
      pp(stackTrace);
      rethrow;
    }
  }
}

