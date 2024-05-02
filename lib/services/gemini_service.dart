import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:sgela_services/data/exam_page_content.dart';
import 'package:sgela_services/sgela_util/functions.dart';

class GeminiService {
  static const mm = '🥨🥨🥨GeminiService 🥨';

  Future<Uint8List> downloadPng(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to download PNG file: ${response.statusCode}');
    }
  }

  Future<Stream<GenerateContentResponse>> send(
      ExamPageContent examPageContent, String prompt) async {
    final model = GenerativeModel(
        model: 'gemini-pro-vision',
        apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
        generationConfig: GenerationConfig(temperature: 0));

    Uint8List m = await downloadPng(examPageContent.pageImageUrl!);
    pp('$mm Prompt: $prompt\n$mm Image File bytes: ${m.length}');

    final content = [
      Content.multi([
        DataPart('image/png', m),
        TextPart(prompt),
      ])
    ];
    final tokenCount = await model.countTokens(content);
    pp('$mm Token count: 🔴${tokenCount.totalTokens}');

    final responses = model.generateContentStream(content);
    var sb = StringBuffer();
    await for (final response in responses) {
      sb.write(response.text);
      pp('$mm response.text: ${response.text}');
    }
    pp('$mm StringBuffer: ${sb.toString()}');
    return responses;
  }

  Future<GenerateContentResponse> sendExamPageContent(
      ExamPageContent examPageContent, String prompt) async {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null) {
      var msg = 'Gemini API Key not found';
      pp('$mm $msg');
      throw Exception(msg);
    }
    final model = GenerativeModel(
        model: 'gemini-pro-vision',
        apiKey: key!,
        generationConfig: GenerationConfig(temperature: 0));

    Uint8List? m;
    try {
      m = await _handleImage(examPageContent, m, prompt);
    } catch (e, s) {
      pp('$mm $e $s');
    }
    if (m == null) {
      throw Exception('Unable to get image bytes');
    }

    final content = [
      Content.system('You are a Mathematics Tutor and Assistant.'
          'You will receive an image from an exam paper.'
          'You extract and solve the math problems contained in the image. '
          'Your users are grade school, medium school, high school students and first and second year college students. '
          'You keep your solutions at grade and high school level and college level. '
          'You think step by step.  '
          'You explain each step of the solution.'
          'You return all responses in LaTex format.'),
      Content.data('image/png', m),
      Content.text(prompt),
    ];
    final imageParts = [
      DataPart('image/png', m),
    ];
    final content2 = Content.multi([TextPart(prompt), ...imageParts]);
    final tokenCount = await model.countTokens(content);
    pp('$mm Token count for this query: 🔴${tokenCount.totalTokens}');

    final response = await model.generateContent([content2],
        generationConfig: GenerationConfig(temperature: 0));
    pp('$mm  🔵🔵query response candidates:  🔵🔵${response.candidates.length}  🔵🔵');
    pp('$mm  🔵🔵query response text:  🔵🔵${response.text}  🔵🔵\n\n');
    pp('$mm  🔵🔵query response promptFeedback:  🔵🔵${response.promptFeedback}  🔵🔵');
    return response;
  }

  Future<Uint8List?> _handleImage(
      ExamPageContent examPageContent, Uint8List? m, String prompt) async {
    if (examPageContent.uBytes == null || examPageContent.uBytes!.isEmpty) {
      if (examPageContent.pageImageUrl != null) {
        m = await downloadPng(examPageContent.pageImageUrl!);
        pp('$mm Prompt: $prompt\n$mm Image File bytes: ${m.length}');
        List<int> list = m.toList();
        examPageContent.uBytes = list;
      }
    } else {
      m = Uint8List.fromList(examPageContent.uBytes!);
    }
    return m;
  }

  static const instructions = 'You are a Mathematics Tutor and Assistant.'
      'You will receive an image from an exam paper.'
      'You extract and solve the math problems contained in the image. '
      'Your users are grade school, medium school, high school students and first and second year college students. '
      'You keep your solutions at grade and high school level and college level. '
      'You think step by step.  '
      'You explain each step of the solution.'
      'You return all responses in LaTex format.';
}
