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
      List<ExamPageContent> examPageContents, String prompt) async {
    final key = dotenv.env['GEMINI_API_KEY'];
    if (key == null) {
      var msg = 'Gemini API Key not found';
      pp('$mm $msg');
      throw Exception(msg);
    }
    pp('$mm sendExamPageContent ... pages: ${examPageContents.length} \nPROMPT: $prompt');
    final model = GenerativeModel(
        model: 'gemini-pro-vision',
        apiKey: key,
        generationConfig: GenerationConfig(temperature: 0));

    List<Uint8List> imageList = [];
    try {
      for (var exam in examPageContents) {
        var m = await _handleImage(exam);
        if (m != null) {
          imageList.add(m);
        }
      }
    } catch (e, s) {
      pp('$mm $e $s');
    }
    if (imageList.isEmpty) {
      throw Exception('Unable to get image bytes');
    }
    List<Content> contents = [];
    var sys = Content.system(instruct);
    contents.add(sys);
    contents.add(Content.text(prompt));
    for (var img in imageList) {
      contents.add( Content('user', [DataPart('image/png', img)]),);
    }

    List<Part> imageParts = [];
    for (var img in imageList) {
      imageParts.add(DataPart('image/png', img));
    }

    var extendedPrompt = '$instruct $prompt';
    final content2 = Content.multi([TextPart(extendedPrompt), ...imageParts]);
    final tokenCount = await model.countTokens(contents);
    pp('$mm Token count for this query: 🔴${tokenCount.totalTokens}');

    final response = await model.generateContent([content2],
        generationConfig: GenerationConfig(temperature: 0));
    pp('$mm  🔵🔵query response candidates:  🔵🔵${response.candidates.length}  🔵🔵');
    pp('$mm  🔵🔵query response text:  🔵🔵${response.text}  🔵🔵\n\n');
    pp('$mm  🔵🔵query response promptFeedback:  🔵🔵${response.promptFeedback}  🔵🔵');
    return response;
  }

  static const instruct = 'You are a Tutor and Assistant. '
      'You will receive images from an exam paper. '
      'You extract all the questions contained in the images. '
      'You answer each question. '
      'Your users are grade school, medium school, high school students and first and second year college students. '
      'You keep your solutions at grade and high school level and college level. '
      'You think step by step.  '
      'You explain each step of the solution.'
      'You return all responses in LaTex format.';
  Future<Uint8List?> _handleImage(ExamPageContent examPageContent) async {
    Uint8List? m;
    if (examPageContent.uBytes == null || examPageContent.uBytes!.isEmpty) {
      if (examPageContent.pageImageUrl != null) {
        m = await downloadPng(examPageContent.pageImageUrl!);
        pp('$mm Prompt: Image File bytes: ${m.length}');
        List<int> list = m.toList();
        examPageContent.uBytes = list;
      }
    } else {
      m = Uint8List.fromList(examPageContent.uBytes!);
    }
    return m;
  }

  static const instructions = 'You are a High School Tutor and Assistant.'
      'You will receive an image from an exam paper.'
      'You extract and solve all the questions problems contained in the image. '
      'Your users are grade school, medium school, high school students and first and second year college students. '
      'You keep your solutions at grade and high school level and college level. '
      'You think step by step.  '
      'You explain each step of the solution.'
      'If your response contains equations, return your response in LaTex format.'
      ' Otherwise, return responses in markdown format. Use headings and paragraphs to improve readability.';
}
