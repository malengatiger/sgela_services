import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../data/exam_link.dart';
import '../data/organization.dart';
import '../services/local_data_service.dart';
import '../sgela_util/dio_util.dart';
import '../sgela_util/environment.dart';
import '../sgela_util/functions.dart';

class BasicRepository {
  final DioUtil dioUtil;

  final Dio dio;
  final LocalDataService localDataService;

  static const mm = '💦💦💦💦 Repository 💦';

  BasicRepository(this.dioUtil, this.localDataService, this.dio);

  Future<Organization?> getSgelaOrganization() async {

    String prefix = ChatbotEnvironment.getSkunkUrl();
    String url = '${prefix}organizations/getSgelaOrganization';
    var result = await dioUtil.sendGetRequest(path:url, queryParameters: {});
    pp('$mm ... response from call: $result');
    Organization org = Organization.fromJson(result.data);
    return org;

  }


  final StreamController<int> _streamController = StreamController.broadcast();

  Stream<int> get pageStream => _streamController.stream;

  static Future<List<File>> downloadFile(String url) async {
    pp('$mm .... downloading file .......................... ');
    try {
      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;
      var mFile = File('someFile');
      mFile.readAsBytesSync();
      return unpackZipFile(mFile);
    } catch (e) {
      pp('Error downloading file: $e');
      rethrow;
    }
  }

  Future<File> downloadOriginalExamPDF(ExamLink examLink) async {
    //todo - check if exists
    Response<List<int>> response = await dio.get<List<int>>(
      examLink.link!,
      options: Options(responseType: ResponseType.bytes),
    );

    // Create a temporary directory to extract the zip file
    Directory tempDir = await Directory.systemTemp.createTemp();
    String tempPath = tempDir.path;

    // Save the downloaded zip file to the temporary directory

    String pdfPath = path.join(tempPath, 'exam_${examLink.id}.pdf');
    File pdfFile = File(pdfPath);
    if (response.data != null) {
      await pdfFile.writeAsBytes(response.data!, flush: true);
    }

    // Extract the zip file
    pp("$mm  Exam pdf file saved "
        " 💙 $pdfPath length: ${(pdfFile.length)} bytes");
    return pdfFile;
  }

  static List<File> unpackZipFile(File zipFile) {
    final destinationDirectory = Directory('zipFiles');

    if (!zipFile.existsSync()) {
      throw Exception('Zip file does not exist');
    }

    if (!destinationDirectory.existsSync()) {
      destinationDirectory.createSync(recursive: true);
    }

    final archive = ZipDecoder().decodeBytes(zipFile.readAsBytesSync());

    final files = <File>[];

    for (final file in archive) {
      final filePath = '${destinationDirectory.path}/${file.name}';
      final outputFile = File(filePath);

      if (file.isFile) {
        outputFile.createSync(recursive: true);
        outputFile.writeAsBytesSync(file.content as List<int>);
        files.add(outputFile);
      } else {
        outputFile.createSync(recursive: true);
        files.add(outputFile);
      }
    }

    return files;
  }
}
