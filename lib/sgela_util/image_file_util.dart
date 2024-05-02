import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/exam_link.dart';
import '../data/exam_page_content.dart';
import 'functions.dart';
import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
class ImageFileUtil {
  static const mm = '🌿🌿🌿 ImageFileUtil 😎😎';

  static Future<List<File>> downloadZipFileWeb({required String url, required int examLinkId}) async {
    pp('$mm .... downloadZipFileWeb:  🍐downloading file .........................\n$url ');
    var start = DateTime.now();

    List<File> files = [];
    try {
      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;
      // var file = File('file.zip');
      // await file.writeAsBytes(bytes);
      // pp('$mm zip file created: ${await file.length()} - ${file.path}');
      if (kIsWeb) {
        pp('$mm .... kIsWeb: downloadZipFileWeb');
        html.window.localStorage['zip_$examLinkId.zip'] = String.fromCharCodes(bytes);
        var end = DateTime.now();
        pp('$mm zip file downloaded: '
            '${(bytes.length / 1024 / 1024).toStringAsFixed(2)}MB bytes; '
            'elapsed: ${end.difference(start).inSeconds} seconds');
      }

      // files =  await _unpackZipFileWeb(file, examLinkId);
      return files;
    } catch (e,s) {
      pp('$mm 👽👽👽👽👽👽👽Error downloading file: $e $s 👽');
      throw Exception('Unable to download file 👽$e 👽');
    }
  }
  static Future<List<File>> downloadZipFile({required String url, required int examLinkId}) async {
    pp('$mm .... downloadZipFile: downloading file .........................\n$url ');
    var start = DateTime.now();
    try {
      //Directory tempDir = Directory.systemTemp;

      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;
      var mFile = File('zips/zip_$examLinkId.zip');
      mFile.writeAsBytesSync(bytes);
      var end = DateTime.now();
      pp('$mm zip file downloaded: '
          '${(await mFile.length()) / 1024 / 1024}MB bytes; '
          'elapsed: ${end.difference(start).inSeconds} seconds');
      return _unpackZipFile(mFile, examLinkId);
    } catch (e,s) {
      pp('$mm 👽👽Error downloading file: 👽$e 👽$s');
      rethrow;
    }
  }
  static Future<List<File>> getExamPageImages(ExamLink examLink) async {
    return _getImageFiles(examLink);
  }
  static Future<List<File>> _getImageFiles(ExamLink examLink) async {
    pp('$mm _getImageFiles ...');
    List<File> files = [];
    // Directory imageDir = Directory(imageDirPath);
    var dir = await getApplicationDocumentsDirectory();

    // if (!dir.existsSync()) {
    //   return _downloadZipFile(url: examLink.pageImageZipUrl!, examLinkId: examLink.id!);
    // }
    downloadZipFileWeb(url: examLink.pageImageZipUrl!, examLinkId: examLink.id!);
    var fileList = dir.listSync(recursive: true);
    double totalSize = 0.0;
    final filePath = '${dir.path}/examPage_${examLink.id!}';

    fileList.sort((a, b) => a.path.compareTo(b.path));
    for (var file in fileList) {
      if (file is File) {
        if (file.path.contains(filePath)) {
          var size = await file.length() / 1024 / 1024;
          totalSize += size;
          pp('$mm File size: ${size.toStringAsFixed(2)} MB,'
              ' path: ${file.path}');
          files.add(file);
        }
      }
    }

    pp('$mm Total directory size: ${totalSize.toStringAsFixed(2)} MB');

    return files;
  }
  Future<void> _openFile(ExamLink examLink) async {

    var dir = await getApplicationDocumentsDirectory();

    var res =  await launchUrl(Uri.parse(examLink.pageImageZipUrl!));
    // if (res) {
    //   launchUrl(url)
    // }
// #enddocregion file
  }
  static Future<File> downloadFile(String url, String fileName) async {
    pp('$mm .... downloading file .........................\n$url ');
    var start = DateTime.now();
    try {
      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;
      Directory tempDir = Directory.systemTemp;
      var mFile = File('${tempDir.path}/$fileName');
      mFile.writeAsBytesSync(bytes);
      var end = DateTime.now();
      pp('$mm file: ${(await mFile.length()) / 1024}K bytes '
          'elapsed: ${end.difference(start).inSeconds} seconds');
      return mFile;
    } catch (e) {
      pp('Error downloading file: $e');
      rethrow;
    }
  }

  static const imageDirPath = 'examPageImages';

  static Future<List<File>> _unpackZipFileWeb(Uint8List zipFile, int examLinkId) async {
    final archive = ZipDecoder().decodeBytes(zipFile);

    final files = <File>[];

    int index = 0;
    for (final file in archive) {
      final filePath = 'directory/examPage_${examLinkId}_$index.png';
      final outputFile = File(filePath);

      if (file.isFile) {
        outputFile.createSync(recursive: true);
        outputFile.writeAsBytesSync(file.content as List<int>);
        files.add(outputFile);
      } else {
        outputFile.createSync(recursive: true);
        files.add(outputFile);
      }
      index++;
    }
    double total = 0.0;
    for (var value in files) {
      var size = (await value.length()) / 1024 / 1024;
      total += size;
      pp('$mm unpacked file: 💙💙 ${size.toStringAsFixed(2)}MB bytes 💙💙 ${value.path}');
    }
    pp('$mm .... files unpacked: ${files.length} '
        'total size: ${total.toStringAsFixed(2)}MB');
    return files;
  }

    static Future<List<File>> _unpackZipFile(File zipFile, int examLinkId) async {
    Directory tempDir = Directory.systemTemp;
    Directory imageDir = Directory(imageDirPath);
    if (!zipFile.existsSync()) {
      throw Exception('Zip file does not exist');
    }

    if (!tempDir.existsSync()) {
      tempDir.createSync(recursive: true);
    }
    if (!imageDir.existsSync()) {
      imageDir.createSync(recursive: true);
    }

    final archive = ZipDecoder().decodeBytes(zipFile.readAsBytesSync());

    final files = <File>[];

    int index = 0;
    for (final file in archive) {
      final filePath = '${imageDir.path}/examPage_${examLinkId}_$index.png';
      final outputFile = File(filePath);

      if (file.isFile) {
        outputFile.createSync(recursive: true);
        outputFile.writeAsBytesSync(file.content as List<int>);
        files.add(outputFile);
      } else {
        outputFile.createSync(recursive: true);
        files.add(outputFile);
      }
      index++;
    }
    double total = 0.0;
    for (var value in files) {
      var size = (await value.length()) / 1024 / 1024;
      total += size;
      pp('$mm unpacked file: 💙💙 ${size.toStringAsFixed(2)}MB bytes 💙💙 ${value.path}');
    }
    pp('$mm .... files unpacked: ${files.length} '
        'total size: ${total.toStringAsFixed(2)}MB');

    return files;
  }

  static Future<List<File>> convertPageContentFiles(
      ExamLink examLink, List<ExamPageContent> pageContents) async {
    pp('$mm ExamPageContents to convert into files: ${pageContents.length}');
    int index = 0;
    final appDir = await getApplicationDocumentsDirectory();
    List<File> realFiles = [];

    for (var img in pageContents) {
      var pathSuffix = '/image_${examLink.id!}_${img.pageIndex}.png';
      var path0 = '${appDir.path}$pathSuffix';
      File x = File(path0);
      if (x.existsSync()) {
        realFiles.add(x);
      } else {
        if (img.pageImageUrl != null) {
          downloadZipFileWeb(url: img.pageImageUrl!, examLinkId: examLink.id!);
          var mFile = await ImageFileUtil.createImageFileFromBytes(img.uBytes!);
          realFiles.add(mFile);
        }
      }
      index++;
    }
    pp('$mm examPageImages turned into files: ${realFiles.length}');
    return realFiles;
  }

  Future<File> trimImage(String imagePath) async {
    File file = File(imagePath);
    List<int> bytes = file.readAsBytesSync();
    Uint8List uint8List = Uint8List.fromList(bytes);
    Image? image = decodeImage(uint8List);
    File? outFile;
    if (image != null) {
      int trimHeight = (image.height * 0.1)
          .round(); // Trim about 10% of the image height from top and bottom
      int croppedHeight = image.height - (2 * trimHeight);

      Image topCroppedImage = copyCrop(image,
          x: 0, y: trimHeight, width: image.width, height: croppedHeight);
      Image trimmedImage = copyCrop(topCroppedImage,
          x: 0, y: 0, width: image.width, height: croppedHeight);

      Directory dir = await getApplicationSupportDirectory();
      String outputPath = '${dir.path}${Platform.pathSeparator}'
          'trimmed-${DateTime.now().millisecondsSinceEpoch}.png';
      File mOutFile = File(outputPath);
      mOutFile.writeAsBytesSync(encodePng(trimmedImage));
      pp('$mm Trimmed image saved to: $outputPath');
      return mOutFile;
    } else {
      pp('$mm Invalid image mOutFile: $imagePath');
      throw Exception('Failed to crop image');
    }
  }

  void main(List<String> args) {
    if (args.isNotEmpty) {
      String imagePath = args[0];
      trimImage(imagePath);
    } else {
      print('Please provide the path to the image file as an argument.');
    }
  }

  static Future<File> createImageFileFromBytes(List<int> bytes) async {
    final appDir = await getApplicationSupportDirectory();
    var filePath = 'f${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${appDir.path}/$filePath');

    // Determine the file extension based on the content
    String fileExtension = '';
    if (bytes.length >= 4) {
      if (bytes[0] == 0x89 &&
          bytes[1] == 0x50 &&
          bytes[2] == 0x4E &&
          bytes[3] == 0x47) {
        fileExtension = '.png';
      } else if (bytes[0] == 0xFF &&
          bytes[1] == 0xD8 &&
          bytes[bytes.length - 2] == 0xFF &&
          bytes[bytes.length - 1] == 0xD9) {
        fileExtension = '.jpg';
      }
    }

    // If the file extension is still empty, fallback to .jpeg
    if (fileExtension.isEmpty) {
      fileExtension = '.jpeg';
    }

    // Append the file extension to the file path
    String finalFilePath = filePath + fileExtension;
    await file.writeAsBytes(bytes);
    // Create a copy of the file with the desired file path
    File copiedFile = await file.copy('${appDir.path}/$finalFilePath');

    return copiedFile;
  }

  static String getMimeType(File file) {
    final mimeTypeResolver = MimeTypeResolver();
    final mimeType = mimeTypeResolver.lookup(file.path);
    return mimeType ?? 'image/png';
  }

  static http.MultipartFile createMultipartFile(
      List<int> bytes, String fieldName, String filename) {
    // Create a byte stream from the bytes list
    var stream = http.ByteStream.fromBytes(bytes);
    // Get the length of the byte stream
    var length = bytes.length;

    // Create the multipart file object
    var multipartFile =
        http.MultipartFile(fieldName, stream, length, filename: filename);

    return multipartFile;
  }

  static Future<File> getFileFromBytes(List<int> bytes) async {
    Directory dir = await getApplicationDocumentsDirectory();
    var path = 'f${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${dir.path}/$path');
    file.writeAsBytesSync(bytes);
    return file;
  }

  static Future<File> getFileFromString(String content, String path) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$path');
    file.writeAsStringSync(content, mode: FileMode.write);
    pp('$mm getFileFromString: ${file.path} - ${await file.length()} bytes');
    return file;
  }

  Future<File> scaleDownImage(File imageFile) async {
    pp('$mm Compress file size: ${await imageFile.length()}');

    final fileSize = await imageFile.length();
    if (fileSize <= 1024 * 1024) {
      pp('$mm Image size is already less than or equal to 1 MB, no need to scale down');
      return imageFile;
    }

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      imageFile.path,
      quality: 85,
      format: imageFile.path.endsWith('.png')
          ? CompressFormat.png
          : CompressFormat.jpeg,
    );
    final filePath = compressedFile?.path;
    var file = File(filePath!);
    pp('$mm Compressed file size: ${await file.length()}');
    return file;
  }

  static Future<File> downloadFileFromFirebase(
      String url, String examLinkId) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.refFromURL(Uri.parse(url).toString());
      Directory tempDir = Directory.systemTemp;
      var mFile = File('${tempDir.path}/$examLinkId.png');
      await ref.writeToFile(mFile);
      print('File downloaded successfully!');
      return mFile;
    } catch (e) {
      print('Error downloading file: $e');
      rethrow;
    }
  }
}
