import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

import '../data/exam_link.dart';
import '../data/exam_page_content.dart';
import 'functions.dart';

class ImageFileUtil {
  static const mm = '🌿🌿🌿 ImageFileUtil 😎😎';

  static Future<List<File>> getFiles(ExamLink examLink) async {
    return await downloadZipFile(examLink.pageImageZipUrl!);
  }

  static Future<List<File>> downloadZipFile(String url) async {
    pp('$mm .... downloading file .........................\n$url ');
    var start = DateTime.now();
    try {
      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;
      Directory tempDir = Directory.systemTemp;
      var mFile = File('${tempDir.path}/someFile.zip');
      mFile.writeAsBytesSync(bytes);
      var end = DateTime.now();
      pp('$mm file: ${(await mFile.length()) / 1024}K bytes '
          'elapsed: ${end.difference(start).inSeconds} seconds');
      return unpackZipFile(mFile);
    } catch (e) {
      pp('Error downloading file: $e');
      rethrow;
    }
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

  static Future<List<File>> unpackZipFile(File zipFile) async {
    Directory destinationDirectory = Directory.systemTemp;

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
    double total = 0.0;
    for (var value in files) {
      var size = (await value.length()) / 1024;
      total += size;
      pp('$mm unpacked file: 💙💙 ${size.toStringAsFixed(2)} 💙💙 ${value.path}');
    }
    pp('$mm .... files unpacked: ${files.length} total size: ${total.toStringAsFixed(2)}K');

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
          downloadZipFile(img.pageImageUrl!);
          var mFile = await ImageFileUtil.createImageFileFromBytes(
              img.uBytes!);
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

  static Future<File> createImageFileFromBytes(
      List<int> bytes) async {
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
}
