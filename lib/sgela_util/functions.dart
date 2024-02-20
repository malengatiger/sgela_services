import 'dart:ffi';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';
import 'package:image/image.dart' as img;
import '../data/gemini/gemini_response.dart';

Logger logger = Logger();
void pp(dynamic msg) {
   // defaults to Level.INFO

  logger.d(msg, time: DateTime.now());
  // var logger = Logger(
  //   printer: PrettyPrinter(
  //       methodCount: 2, // Number of method calls to be displayed
  //       errorMethodCount: 8, // Number of method calls if stacktrace is provided
  //       lineLength: 120, // Width of the output
  //       colors: true, // Colorful log messages
  //       printEmojis: true, // Print an emoji for each log message
  //       printTime: false // Should each log print contain a timestamp
  //   ),
  // );
}

bool isValidLaTeXStrings(String text) {
  // Define a regular expression pattern to match special characters or phrases
  final pattern = RegExp(r'\\(|\\)|\\[|\\]|\\frac|\\cdot');
  // Check if the text matches the pattern
  return pattern.hasMatch(text);
}

Future<File?> compressImages({required File file, required int quality}) async {
  final tempDir = await getTemporaryDirectory();
  final tempPath = tempDir.path;
  final fileName = file.path.split('/').last;
  final fileType = fileName.split('.').last;
  final compressedFile =
  File('$tempPath/f_${DateTime.now().millisecondsSinceEpoch}.$fileType');
  pp('🌍🌍🌍🌍compressing file, size: ${await file.length()} bytes, quality: $quality');
  final fileSize = await file.length();
  if (fileSize < 2 * 1024 * 1024) {
    pp('🌍🌍🌍🌍file NOT compressed, no need to, size: ${await file.length()} bytes');
    return file;
  }
  File? resultFile;
  if (fileSize > 2 * 1024 * 1024) {
    if (fileType == 'jpg' || fileType == 'jpeg') {
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        compressedFile.absolute.path,
        quality: quality,
      );
      resultFile = File(result!.path);
      var size = await resultFile.length();
      pp('🌍🌍🌍🌍compressed file, size: $size bytes');
      if (size > 3 * 1024 * 1024) {
        pp('🌍🌍🌍🌍compressed file still too big, bigger than 3MB: ${await resultFile.length()} bytes');
        return compressImages(file: resultFile, quality: 60);
      }
      return resultFile;
    } else {
      //todo - compress .png image - cannot be compressed by FlutterImageCompress
      if (fileType == 'png') {
        final image = img.decodeImage(file.readAsBytesSync());
        final compressedImage = img.encodePng(image!, level: quality);

        await compressedFile.writeAsBytes(compressedImage);
        resultFile = compressedFile;

        final size = await resultFile.length();
        pp('Compressed file, size: $size bytes');

        if (size > 3 * 1024 * 1024) {
          pp('Compressed file still too big, bigger than 3MB: ${await resultFile.length()} bytes');
          return compressImages(file: resultFile, quality: 60);
        }
      }
    }
    return resultFile;
  }
  return file;
}

String getResponseString(MyGeminiResponse geminiResponse) {
  var sb = StringBuffer();
  geminiResponse.candidates?.forEach((candidate) {
    candidate.content?.parts?.forEach((parts) {
      sb.write(parts.text ?? '');
      sb.write('\n');
    });
  });
  return sb.toString();
}

String formatMilliseconds(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();
  seconds %= 60;

  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr';
}

bool isMarkdownFormats(String text) {
  // Markdown heading pattern: # Heading
  final headingPattern = RegExp(r'^#\s');

  // Markdown bold pattern: **Bold**
  final boldPattern = RegExp(r'\*\*.*\*\*');

  // Markdown italic pattern: *Italic*
  final italicPattern = RegExp(r'\*.*\*');

  // Markdown link pattern: [Link](https://example.com)
  final linkPattern = RegExp(r'\[.*\]\(.*\)');

  // Check if the text matches any of the Markdown patterns
  if (headingPattern.hasMatch(text) ||
      boldPattern.hasMatch(text) ||
      italicPattern.hasMatch(text) ||
      linkPattern.hasMatch(text)) {
    return true;
  }

  return false;
}

