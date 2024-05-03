import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:archive/archive.dart';
import '../data/exam_link.dart';
import 'functions.dart';

class HttpUtility {
  static const mm = '🔵🔵🔵 HttpUtility 💛💛';

  static Future<http.Response> get(
      {required String url, required dynamic headers}) async {
    try {
      pp('$mm .... sending http get request: $url \nheaders: $headers');

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(minutes: 5));
      return response;
    } catch (e, stackTrace) {
      pp('$mm Error occurred during GET request: $e');
      pp(stackTrace);
      rethrow;
    }
  }

  static Future<http.Response> post(
      {required String url,
      required dynamic body,
      required dynamic headers}) async {
    var start = DateTime.now();

    try {
      pp('$mm .... sending http post request: '
          '$url \nheaders: $headers - timeout is 5 minutes');
      http.Response response = await http
          .post(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(Duration(minutes: 5));
      var end = DateTime.now();
      pp('$mm ... 🔵🔵🔵 post request: ${end.difference(start)} seconds elapsed');
      return response;
    } catch (e, stackTrace) {
      pp('$mm Error occurred during POST request: $e');
      if (e is TimeoutException) {
        var end = DateTime.now();
        pp('$mm Timeout occurred during POST request: $e\n'
            ' 👿 👿It took ${end.difference(start)} seconds before we fell downstairs! 👿 ');
      } else {
        // Handle other types of exceptions
        pp('$mm  👿 👿 Error occurred during POST request:  👿$e - $stackTrace');
      }
      pp(stackTrace);
      rethrow;
    }
  }



  static Future<List<String>> downloadAndUnpackZip(ExamLink link) async {
    try {
      Directory dir = Directory('examPages');
      var response = await http.get(Uri.parse(link.pageImageZipUrl!));
      if (response.statusCode == 200) {
        var file = File('${dir.path}/${link.id!}.png');
        await file.writeAsBytes(response.bodyBytes);
        pp('zipped File downloaded successfully! ${await file.length()} bytes');

        var archive = ZipDecoder().decodeBytes(file.readAsBytesSync());
        List<String> extractedFilePaths = [];

        int index = 0;
        for (var file in archive) {
          var extractedPath = '${dir.path}/examPage${link.id}_$index.png';
          if (file.isFile) {
            var extractedFile = File(extractedPath);
            extractedFile.createSync(recursive: true);
            extractedFile.writeAsBytesSync(file.content as List<int>);
            extractedFilePaths.add(extractedPath);
          } else {
            Directory(extractedPath).create(recursive: true);
          }
        }
        print('File unpacked successfully!');
        return extractedFilePaths;
      } else {
        print('Error downloading file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading and unpacking file: $e');
    }
    return [];
  }}
