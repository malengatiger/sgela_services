import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_download_manager/flutter_download_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sgela_services/data/exam_page_content.dart';
import 'package:sgela_services/sgela_util/environment.dart';
import 'package:sgela_services/sgela_util/http_utility.dart';

import 'functions.dart';
import 'image_file_util.dart';

class ExamPageDownloader {
  static const mm = ' 🥦🥦🥦ExamPageDownloader 🥦 ';

  static Future<List<ExamPageContent>> extractPageContentForExam(
      int examLinkId) async {
    List<ExamPageContent> list = [];
    pp('$mm .................. extractPageContentForExam: , examLinkId: $examLinkId ... ');

    try {
      var url = '${ChatbotEnvironment.getSkunkUrl()}'
          'examPageContents/extractPageContentForExam?examLinkId=$examLinkId';
      http.Response response = await HttpUtility.get(url: url, headers: {
        'Content-Type': 'application/json'
      });
      if (response.statusCode == 200) {
        List mList = jsonDecode(response.body);
        for (var epc in mList) {
          list.add(ExamPageContent.fromJson(epc));
        }
      }
    } catch (e, s) {
      var msg = 'Exam page contents failed to download\n$e';
      pp('$mm $msg - $s');
      throw Exception(msg);
    }
    pp('$mm ......... ExamPageContents sourced from Skunk backend - ${list.length}');

    return list;
  }

  static Future<List<File>> downloadFiles(List<String> urls) async {
    List<File> files = [];

    Directory directory = await getApplicationDocumentsDirectory();
    var dl = DownloadManager();

    try {
      await dl.addBatchDownloads(urls, directory.path);
      var downloadProgress = dl.getBatchDownloadProgress(urls);
      downloadProgress.addListener(() {
        pp('$mm ... downloadProgress.value: ${downloadProgress.value}');
      });

      var concurrentTasks = dl.maxConcurrentTasks;
      pp('$mm ... downloadProgress concurrentTasks: $concurrentTasks');
      List<DownloadTask?>? tasks = await dl.whenBatchDownloadsComplete(urls,
          timeout: const Duration(seconds: 120));
      tasks?.forEach((task) async {
        if (task?.status.value == DownloadStatus.downloading) {
          pp('$mm ... downloading progress: ${task?.progress.value} ...');
        }
        if (task?.status.value == DownloadStatus.completed) {
          pp('$mm ... completed ... progress: ${task?.progress.value}');
          File file = File(task!.request.path);
          files.add(file);
          pp('$mm ... completed ... file: ${file.path} - ${await file.length()} bytes');
        }
        if (task?.status.value == DownloadStatus.failed) {
          pp('$mm ... downloading failed ... progress: ${task?.progress.value} status: ${task?.status.value.name}');
        }
        if (task?.status.value == DownloadStatus.queued) {
          pp('$mm ... downloading queued ...progress: ${task?.progress.value}');
        }
      });
    } catch (e, s) {
      pp('$mm ERROR: $e - $s');
    }

    pp('$mm Downloads complete. 🍎🍎Returning ${files.length} files 🍎🍎');
    return files;
  }

  static List<File> files = [];
  static final StreamController<List<File>> _streamController =
      StreamController.broadcast();

  static Stream<List<File>> get fileStream => _streamController.stream;

  static Future<List<File>> downloadFilesWithIsolates(
      List<String> urls, List<String> fileNames) async {
    int cnt = 0;
    for (var url in urls) {
      var file = await Isolate.run(
          () => _getFile(url: url, fileName: fileNames.elementAt(cnt)),
          debugName: 'ISOLATE#$cnt');
      files.add(file);
      cnt++;
    }

    return files;
  }

  static Future<File> _getFile(
      {required String url, required String fileName}) async {
    File f = await ImageFileUtil.downloadFile(url, fileName);
    files.add(f);
    pp('$mm File downloaded: ${f.path}');
    _streamController.sink.add(files);
    return f;
  }
}
