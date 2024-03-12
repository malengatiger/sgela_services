import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sgela_services/data/assistant_data_openai/assistant.dart';
import 'package:sgela_services/data/assistant_data_openai/assistant_file.dart';
import 'package:sgela_services/data/assistant_data_openai/message.dart';
import 'package:sgela_services/data/assistant_data_openai/model.dart';
import 'package:sgela_services/data/assistant_data_openai/run.dart';
import 'package:sgela_services/data/assistant_data_openai/thread.dart';
import 'package:sgela_services/data/subject.dart';
import 'package:sgela_services/services/firestore_service.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/environment.dart';
import 'package:sgela_services/sgela_util/functions.dart';

class OpenAIAssistantService {
  /*
  Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RoutesResolver] AssistantController {/assistant}: +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/runThread, GET} route +1ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/checkRunStatus, GET} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/getThreadMessages, GET} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/getAssistants, GET} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/getThread, GET} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/listModels, GET} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/uploadFiles, POST} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/createAssistant, POST} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/createMessage, POST} route +0ms
[Nest] 85786  - 03/11/2024, 5:37:27 AM     LOG [RouterExplorer] Mapped {/assistant/createThread, POST} route +0ms
   */

  final DioUtil dioUtil;
  static const defaultModel = 'gpt-4-turbo-preview';
  static const mm = '🥦🥦🥦 OpenAIAssistantService 🥦🥦🥦';

  OpenAIAssistantService(this.dioUtil);

  final StreamController<List<Message>> _msgController =
      StreamController.broadcast();

  Stream<List<Message>> get messageStream => _msgController.stream;

  final StreamController<String> _statusController =
      StreamController.broadcast();

  Stream<String> get statusStream => _statusController.stream;

  //
  Future<OpenAIAssistant?> findAssistant(String subject) async {
    FirestoreService fs = GetIt.instance<FirestoreService>();
    List<OpenAIAssistant> assistants = await fs.getOpenAIAssistants();
    OpenAIAssistant? found;
    for (var value in assistants) {
      if (value.name!.contains(subject)) {
        return value;
      }
    }
    return found;
  }
  /*
    🥦🥦🥦
    1. findAssistant by subject
    2. create Assistant, save in firestore
    3. upload exam paper pdf
    4. create thread with message and uploaded file id
    5. run thread
    6. poll run thread
    7. when complete status - getThread messages
    8. put result messages in stream
    9. send subsequent messages to the stream
    10. Get question list - to be used to select questions
    11. Get study plan - to be written out as pdf and markdown
    12. Start freeform messages to Assistant ...
    13. Rate your experience ... 🥦🥦🥦
   */

  Future<OpenAIAssistant?> createAssistant({required Subject subject,
    String? model,
  }) async {
    OpenAIAssistant? openAIAssistant;
    FirestoreService fs = GetIt.instance<FirestoreService>();
    try {
      pp('$mm assistant instructions: $generalInstructions');
      var mName = 'SgelaAI Tutor Assistant - ${subject.title!}';
      var mDesc = 'Expert Tutor and Assistant to help students and teachers with:  ${subject.title!}';
      var inst = generalInstructions.replaceAll('#SUBJECT', subject.title!);
      var inputAssistant = OpenAIAssistant(
          name: mName,
          description: mDesc,
          instructions: inst,
          tools: [
            Tools(type: 'retrieval'),
          ],
          model: model ?? defaultModel,
          fileIds: []);
      pp('$mm ....... create inputAssistant: ${inputAssistant.toJson()}');
      //send request
      Response response = await dioUtil.sendPostRequest(
          path: '${ChatbotEnvironment.getGeminiUrl()}assistant/createAssistant',
          body: inputAssistant.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        var mJson = jsonDecode(response.data);
        openAIAssistant = OpenAIAssistant.fromJson(mJson);
        openAIAssistant.subjectId = subject.id!;
        openAIAssistant.subjectTitle = subject.title!;
        openAIAssistant.date = DateTime.now().toUtc().toIso8601String();
        await fs.addOpenAIAssistant(openAIAssistant);
        pp('$mm ... openAIAssistant: 🔵🔵🔵 ${openAIAssistant.toJson()} 🔵');
      } else {
        throw Exception('Create Assistant Failed; statusCode: '
            '${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Create Assistant Failed: $e');
    }

    return openAIAssistant;
  }

  Future<AssistantFile?> uploadFile(File file) async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/uploadFile';
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();

    var multipartFile = http.MultipartFile(
      'file',
      stream,
      length,
      filename: file.path.split('/').last,
      contentType: MediaType.parse(
          lookupMimeType(file.path) ?? 'application/octet-stream'),
    );
    request.files.add(multipartFile);
    AssistantFile? assistantFile;
    //
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var uploadedAssistantFile = await response.stream.bytesToString();
        var mJson = jsonDecode(uploadedAssistantFile);
        pp('$mm uploaded Assistant File: $mJson');
        assistantFile = AssistantFile.fromJson(mJson['result']);
      } else {
        throw Exception(
            'Failed to upload file: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to upload file: $e');
    }
    return assistantFile;
  }

  Future<Message> createMessage(
      String threadId, String text, File? file) async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/createMessage';

    AssistantFile? uploadedFile;
    Message? message;
    List<String> fileIds = [];
    if (file != null) {
      uploadedFile = await uploadFile(file);
    }
    if (uploadedFile != null) {
      fileIds.add(uploadedFile.id!);
    }
    var messageBody = {
      'threadId': threadId,
      'content': text,
      'fileId': uploadedFile?.id!,
    };
    try {
      Response res =
          await dioUtil.sendPostRequest(path: url, body: messageBody);
      if (res.statusCode == 200 || res.statusCode == 201) {
        var mJson = jsonDecode(res.data);
        message = Message.fromJson(mJson);
        return message;
      } else {
        throw Exception(
            'Failed to create message; error: ${res.statusCode} - ${res.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to create message; error: $e');
    }
  }

  Future<Thread> createThread(String text, File? file) async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/createThread';
    //todo - 🥦🥦🥦add uploaded file in the Thread or subsequent Messages ??????
    Thread? thread;
    AssistantFile? assistantFile;
    if (file != null) {
      assistantFile = await uploadFile(file);
    }

    var json = {
      'role': 'user',
      'content': text,
      'fileIds': assistantFile == null ? [] : [assistantFile.id]
    };
    try {
      Response res = await dioUtil.sendPostRequest(path: url, body: json);
      if (res.statusCode == 200 || res.statusCode == 201) {
        var mJson = jsonDecode(res.data);
        thread = Thread.fromJson(mJson);
        return thread;
      } else {
        throw Exception(
            'Failed to create thread; statusCode: ${res.statusCode}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to create thread; error: $e');
    }
  }

  Future<void> runThread(
      {required String threadId, required String assistantId}) async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/runThread';

    try {
      Response res = await dioUtil.sendPostRequest(path: url, body: {
        'threadId': threadId,
        'assistantId': assistantId,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        var mJson = jsonDecode(res.data);
        var run = Run.fromJson(mJson);
        pp('$mm ... run thread returned, '
            'will start polling ...: ${run.toJson()}');
        pollThread(threadId, run.id!);
      } else {
        throw Exception(
            'Failed to run thread; statusCode: ${res.statusCode}  ${res.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to create thread; error: $e');
    }
  }

  Future<List<Message>> getThreadMessages({required String threadId}) async {
    pp('$mm ... getThreadMessages started ... threadId: $threadId');
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/getThreadMessages';
    List<Message> messages = [];
    try {
      Response res = await dioUtil
          .sendGetRequest(path: url, queryParameters: {'threadId': threadId});
      if (res.statusCode == 200) {
        List json = res.data;
        for (var value in json) {
          messages.add(Message.fromJson(value));
        }
        pp('$mm ... getThreadMessages messages found: ${messages.length}'
            ' ... put on message stream ...');
        _msgController.sink.add(messages);
        return messages;
      } else {
        pp('$mm ... getThreadMessages messages found: ZERO!!');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to create thread; error: $e');
    }
    return messages;
  }

  Future<Run> pollThread(String threadId, String runId) async {
    pp('$mm ... pollThread started ... runId: $runId threadId: $threadId');
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/checkRunStatus';

    String? completed;

    try {
      while (completed == null) {
        Future.delayed(Duration(seconds: 5), () async {
          Response res = await dioUtil.sendGetRequest(
              path: url,
              queryParameters: {'runId': runId, 'threadId': threadId});
          if (res.statusCode == 200 || res.statusCode == 201) {
            var mJson = jsonDecode(res.data);
            var run = Run.fromJson(mJson);
            if (run.status != null) {
              switch (run.status) {
                case Status.queued:
                  pp('$mm Run status: ${Status.queued}');
                  _statusController.sink.add(Status.queued.name);
                  break;
                case Status.in_progress:
                  pp('$mm Run status: ${Status.in_progress}');
                  _statusController.sink.add(Status.in_progress.name);
                  break;
                case Status.completed:
                  completed = 'yes';
                  pp('$mm Run status: ${Status.completed}');
                  _statusController.sink.add(Status.completed.name);
                  getThreadMessages(threadId: threadId);
                  return run;
                  break;
                case Status.cancelling:
                  pp('$mm Run status: ${Status.cancelling}');
                  _statusController.sink.add(Status.cancelling.name);

                  break;
                case Status.cancelled:
                  pp('$mm Run status: ${Status.cancelled}');
                  _statusController.sink.add(Status.cancelled.name);

                  break;
                case Status.failed:
                  pp('$mm Run status: ${Status.failed}');
                  _statusController.sink.add(Status.failed.name);

                  break;
                case Status.expired:
                  pp('$mm Run status: ${Status.expired}');
                  _statusController.sink.add(Status.expired.name);

                  break;
                case Status.requires_action:
                  pp('$mm Run status: ${Status.requires_action}');
                  _statusController.sink.add(Status.requires_action.name);

                  break;
                case null:
                  pp('$mm Run status is null');
                  break;
              }
            }
            pp('\n\n$mm ... result from poll, run: ${res.data}');
          } else {
            throw Exception(
                'Failed to get Run status: ${res.statusCode} ${res.statusMessage}');
          }
        });
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to get Run status: $e');
    }
    throw Exception('Failed to get Run status: unknown status');
  }

  Future<List<OpenAIAssistant>> listAssistants() async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/listAssistants';

    List<OpenAIAssistant> mList = [];
    try {
      Response res = await dioUtil.sendGetRequestWithHeaders(
          path: url, queryParameters: {}, headers: {});
      if (res.statusCode == 200) {
        List mJson = jsonDecode(res.data);
        for (var value in mJson) {
          mList.add(OpenAIAssistant.fromJson(value));
        }
      } else {
        throw Exception(
            'Failed to list OpenAI assistants; statusCode: ${res.statusCode}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to list OpenAI models; $e');
    }
    return mList;
  }

  Future<List<Model>> listModels() async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/listModels';

    List<Model> mList = [];
    try {
      Response res = await dioUtil.sendGetRequestWithHeaders(
          path: url, queryParameters: {}, headers: {});
      if (res.statusCode == 200) {
        List mJson = jsonDecode(res.data);
        for (var value in mJson) {
          mList.add(Model.fromJson(value));
        }
      } else {
        throw Exception(
            'Failed to list OpenAI models; statusCode: ${res.statusCode}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to list OpenAI models');
    }
    return mList;
  }
}

const String generalInstructions = ''' 
Your name is SgelaAI and you are a Tutor and Assistant who will help me study and prepare for exams. The uploaded file contains test and exam questions.  
You are very knowledgeable and expert in this subject: #SUBJECT. You will focus your responses on this subject.

I uploaded a exam paper document containing multiple choice and descriptive questions. 
Please extract all questions from the document and present them in JSON format following this schema:

- fileName (string): The name of the document.
- sectionName (string): The name of the section where the question is found.
- subSectionName (string, optional): The name of the subsection, if applicable.
- questionNumber (string): A unique identifier for the question within its section.
- subQuestionNumber (string, optional): A unique identifier for sub-questions, if present.
- questionText (string): The full text of the question.
- subQuestionText (array of strings, optional): A list containing the text of each sub-question, if applicable.
- index (integer): A unique index for each question for easy reference.

Example:
[
  {
    "fileName": "Business Studies Exam.pdf",
    "sectionName": "SECTION A",
    "subSectionName": "",
    "questionNumber": "1",
    "subQuestionNumber": "",
    "questionText": "What is the primary goal of business management?",
    "subQuestionText": [],
    "index": 1
  },
  {
    "fileName": "Business Studies Exam.pdf",
    "sectionName": "SECTION B",
    "subSectionName": "Economics Foundation",
    "questionNumber": "2",
    "subQuestionNumber": "2.1",
    "questionText": "Explain the role of the Federal Reserve.",
    "subQuestionText": ["2.1.1 What are the tools used by the Federal Reserve in monetary policy?", "2.1.2 How does the Federal Reserve influence interest rates?"],
    "index": 2
  }
]
It is VERY IMPORTANT that you use this JSON schema when building the list. The list is used by an automated downstream process.
Can you fill this schema with questions found in the uploaded document?

When you are asked for a study or preparation plan ensure that the plan covers all the question areas. 
Identify Key Topics for Each Week:

Break down the syllabus or study material into manageable topics that can be covered over the selected period (e.g., 6 weeks).
Assign each topic to a specific week, ensuring a logical progression that builds upon previously covered content.
Curate Resources:

For each week, search for relevant study materials including videos, articles, and online tools.
Ensure you gather a diverse selection of resources to cater to different learning styles (visual, auditory, reading/writing, and kinesthetic).
Design Activities:

Based on the focus and resources for each week, design specific activities that will reinforce learning, such as writing summaries, presenting topics, or solving practice questions.
Make sure activities encourage active learning and are directly related to the week's objectives.
Compile the Plan:

Start populating the JSON schema with the information for each week, following the established structure.
For each "week" object, fill in the "weekNumber", "focus", "objectives", "resources", and "activities" with the corresponding details.
Include YouTube links for research.
Include textbook links for research.
Include at least 6 research links for each week

The plan should ALWAYS be created using the JSON schema below: 
weekNumber will hold an integer value representing the week of study.
focus is a summary of what the main focus of the week will be.
objectives explains what we intend to achieve by the end of the week.
resources is an array of objects each containing:
type (e.g., "Video", "Article", etc.),
link to the resource,
description of what the resource covers.
activities is an array of objects containing:
days indicating when the activity should be done within the week,
description of what the activity is.

relatedQuestions are a list of the questions involved or handled this week.

The schema for the plan:
{
  "weeks": [
    {
      "weekNumber": Number of the week,
      "focus": The focus of the week,
      "objectives": What I want to achieve this week,
      "researchResources": [
        {
          "type": The type of resource,
          "link": The url to the research content,
          "description": Description of the research resource
        }
      ],
      "activities": [
        {
          "days": The day or days of the activity,
          "description": Description of the activity
        }
      ],
      "relatedQuestions": [
        {
          "questionNumber": Number of the question,
          "questionText": Text of the question
        }
      ]
    }
  ]
}

Please REMEMBER to use the JSON schemas above for the question list and the study plan.
Please REMEMBER that both the list and the plan are required for downstream processes and should not be truncated.

''';
