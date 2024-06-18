import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sgela_services/data/assistant_data_openai/assistant.dart';
import 'package:sgela_services/data/assistant_data_openai/assistant_file.dart';
import 'package:sgela_services/data/assistant_data_openai/message.dart';
import 'package:sgela_services/data/assistant_data_openai/model.dart';
import 'package:sgela_services/data/assistant_data_openai/run.dart';
import 'package:sgela_services/data/assistant_data_openai/thread.dart';
import 'package:sgela_services/data/exam_link.dart';
import 'package:sgela_services/data/tokens_used.dart';
import 'package:sgela_services/services/firestore_service.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/environment.dart';
import 'package:sgela_services/sgela_util/functions.dart';

import '../data/assistant_data_openai/run_details.dart';
import '../data/sponsoree.dart';

class OpenAIAssistantService {
  final DioUtil dioUtil;
  static const defaultModel = 'gpt-4-turbo-preview';
  static const mm = '🥦🥦🥦 OpenAIAssistantService 🥦🥦🥦';

  OpenAIAssistantService(this.dioUtil);

  final StreamController<List<Message>> _msgController =
      StreamController.broadcast();

  Stream<List<Message>> get messageStream => _msgController.stream;
  final StreamController<List<Message>> _questionController =
      StreamController.broadcast();

  Stream<List<Message>> get questionResponseStream =>
      _questionController.stream;

  final StreamController<String> _statusController =
      StreamController.broadcast();

  Stream<String> get statusStream => _statusController.stream;

  //
  Future<OpenAIAssistant?> findAssistant(ExamLink examLink) async {
    FirestoreService fs = GetIt.instance<FirestoreService>();
    List<OpenAIAssistant> assistants = await fs.getOpenAIAssistants();
    OpenAIAssistant? found;
    for (var value in assistants) {
      pp('$mm Assistant: ${value.name} ');
    }
    for (var value in assistants) {
      if (value.examLinkId! == examLink.id!) {
        pp('$mm Assistant found for subject: 🍎${value.name} 🍎 ');
        return value;
      }
    }
    pp('$mm Assistant for ${examLink.title} NOT found');
    return found;
  }

  /*
    🥦🥦🥦
    1. findAssistant by subject
    2. create Assistant if required, save in firestore
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

  Future<OpenAIAssistant?> createAssistant(
      {required ExamLink examLink, String? model}) async {
    OpenAIAssistant? openAIAssistant;
    FirestoreService fs = GetIt.instance<FirestoreService>();
    try {
      pp('$mm assistant examLink: ${examLink.toJson()}');

      //pp('$mm assistant instructions: $generalInstructions');
      var mName = 'SgelaAI Tutor/Assistant - ${examLink.title!}';
      var mDesc =
          'Expert Tutor and Assistant to help students and teachers with:  ${examLink.title!}';
      var inst =
          generalInstructions.replaceAll('#SUBJECT', examLink.subject!);
      AssistantFile? uploadedFile;

      var fileName = '${examLink.documentTitle}'.replaceAll('/', '-');
      fileName = '${examLink.subject} $fileName ${examLink.title}.pdf';
      File? file = await downloadFile(examLink.link!, fileName);
      uploadedFile = await uploadFile(file);
      var inputAssistant = OpenAIAssistant(
          name: mName,
          description: mDesc,
          instructions: inst,
          tools: [
            Tools(type: 'retrieval'),
          ],
          model: model ?? defaultModel,
          fileIds: uploadedFile == null ? [] : [uploadedFile.id!]);
      pp('$mm ....... create inputAssistant: ${inputAssistant.toJson()}');
      //send request
      Response response = await dioUtil.sendPostRequest(
          path: '${ChatbotEnvironment.getGeminiUrl()}assistant/createAssistant',
          body: inputAssistant.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        openAIAssistant = OpenAIAssistant.fromJson(response.data);
        openAIAssistant.subjectId = examLink.id!;
        openAIAssistant.subjectTitle = examLink.title!;
        openAIAssistant.examLinkId = examLink.id;
        openAIAssistant.examLinkTitle = examLink.title;
        openAIAssistant.date = DateTime.now().toUtc().toIso8601String();
        openAIAssistant.fileIds = [uploadedFile!.id!];
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
    pp('$mm ....... start to upload Assistant file: ${file.path}');
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        var uploadedAssistantFile = await response.stream.bytesToString();
        var mJson = jsonDecode(uploadedAssistantFile);
        pp('\n\n$mm uploaded Assistant pdf File: 🍎💛💛💛 $mJson\n\n');
        assistantFile = AssistantFile.fromJson(mJson['result']);
      } else {
        pp('$mm Failed to upload file: statusCode: ${response.statusCode} '
            'reasonPhrase: ${response.reasonPhrase}');
        throw Exception(
            'Failed to upload file: statusCode: ${response.statusCode} '
            'reasonPhrase: ${response.reasonPhrase}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to upload file: $e');
    }
    return assistantFile;
  }

  Future<Message> createMessage(
      {required String threadId, required String text}) async {
    pp('$mm ....... createMessage:  threadId: $threadId .... text length: ${text.length}');

    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/createMessage';

    Message? message;

    var messageBody = {
      'threadId': threadId,
      'content': text,
    };
    try {
      Response res =
          await dioUtil.sendGetRequest(path: url, params: messageBody);
      if (res.statusCode == 200 || res.statusCode == 201) {
        message = Message.fromJson(res.data);
        pp('$mm created message, id: 🍎 ${message.id} 🍎');
        return message;
      } else {
        pp('$mm FAILED: create message: statusCode: '
            '${res.statusCode} msg: ${res.statusMessage}');

        throw Exception(
            'Failed to create message;  👿👿👿👿statusCode: ${res.statusCode} - ${res.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm  👿👿👿👿$e $s');
      throw Exception('Failed to create message; error: $e');
    }
  }

  /*
    Message.Beta.Threads.Messages.ThreadMessage
    messages: [
        {role: 'user', content: '', metadata: {}, file_ids: []},
      ],

    */
  Future<Thread> createThreadWithMessages(List<dynamic> messages) async {
    var url =
        '${ChatbotEnvironment.getGeminiUrl()}assistant/createThreadWithMessages';
    pp('\n\n$mm ....createThreadWithMessages  thread .............\n');

    Thread? thread;
    List<dynamic> mList = [];
    for (var msg in messages) {
      mList.add({
        'role': msg['role'],
        'content': msg['content'],
        'metadata': msg['metadata'],
        'file_ids': [],
      });
    }
    Map<String, dynamic> body = {'metadata': {}, 'messages': mList};

    try {
      Response res = await dioUtil.sendPostRequest(path: url, body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        thread = Thread.fromJson(res.data);
        pp('\n$mm created thread: 🍎🍎🍎🍎 ${thread.toJson()} 🍎\n');
        return thread;
      } else {
        pp('$mm FAILED: create thread: statusCode: '
            '${res.statusCode} msg: ${res.statusMessage}');
        throw Exception(
            'Failed to create thread; statusCode: ${res.statusCode}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to create thread; error: $e');
    }
  }

  Future<Thread> createThread() async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/createThread';
    pp('\n\n$mm .... create Assistant thread .............\n');

    Thread? thread;

    try {
      Response res = await dioUtil.sendGetRequest(path: url, params: {});
      if (res.statusCode == 200 || res.statusCode == 201) {
        thread = Thread.fromJson(res.data);
        pp('\n$mm created thread: 🍎🍎🍎🍎 ${thread.toJson()} 🍎\n');
        return thread;
      } else {
        pp('$mm FAILED: create thread: statusCode: '
            '${res.statusCode} msg: ${res.statusMessage}');
        throw Exception(
            'Failed to create thread; statusCode: ${res.statusCode}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to create thread; error: $e');
    }
  }

  Future<Run> runThread(
      {required String threadId, required String assistantId}) async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/runThread';
    pp('$mm ....... start to run thread: $threadId assistantId: $assistantId');

    late Run run;
    try {
      Response res = await dioUtil.sendGetRequest(path: url, params: {
        'threadId': threadId,
        'assistantId': assistantId,
      });
      if (res.statusCode == 200 || res.statusCode == 201) {
        run = Run.fromJson(res.data);
        pp('\n\n$mm ... thread Run returned, '
            'will start polling ... 🔵🔵🔵🔵🔵🔵 run: ${run.id} ${run.status} ${run.threadId}');
      } else {
        pp('$mm FAILED: run thread: statusCode: '
            '${res.statusCode} msg: ${res.statusMessage}');
        throw Exception(
            'Failed to run thread; statusCode: ${res.statusCode}  ${res.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      throw Exception('Failed to run thread; error: $e');
    }
    return run;
  }

  Future getTokens(
      {required Sponsoree sponsoree,
      required String threadId,
      required String model}) async {
    var runs = await _getThreadRuns(threadId: threadId);
    int total = 0, promptTotal = 0, completionTotal = 0;

    for (var r in runs) {
      total += r.usage!.totalTokens!;
      promptTotal += r.usage!.promptTokens!;
      completionTotal += r.usage!.completionTokens!;
    }

    var tu = TokensUsed(
        organizationId: sponsoree.organizationId,
        sponsoreeId: sponsoree.id,
        date: DateTime.now().toUtc().toIso8601String(),
        sponsoreeName: sponsoree.sgelaUserName,
        organizationName: sponsoree.organizationName,
        promptTokens: promptTotal,
        completionTokens: completionTotal,
        model: model,
        totalTokens: total);

    FirestoreService firestoreService = GetIt.instance<FirestoreService>();
    await firestoreService.addTokensUsed(tu);
  }

  Future<List<RunDetails>> _getThreadRuns({required String threadId}) async {
    List<RunDetails> runs = [];
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/getThreadRuns';

    try {
      Response res = await dioUtil
          .sendGetRequest(path: url, params: {'threadId': threadId});
      if (res.statusCode == 200 || res.statusCode == 201) {
        List json = res.data;
        for (var value in json) {
          runs.add(RunDetails.fromJson(value));
        }
        pp('$mm ... getThreadRuns found: ${runs.length}');
        for (var run in runs) {
          pp('$mm run: ${run.toJson()}');
        }
        return runs;
      } else {
        pp('$mm ... getThreadRuns 👿👿'
            'BAD RESPONSE: statusCode: ${res.statusCode} '
            '${res.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm  👿👿👿👿$e $s');
      throw Exception('Failed to getThreadRuns; error: $e');
    }

    return runs;
  }

  Future<List<Message>> getThreadMessages(
      {required String threadId, required bool isQuestion}) async {
    pp('$mm ... getThreadMessages started ... threadId: $threadId');
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/getThreadMessages';
    List<Message> messages = [];
    try {
      Response res = await dioUtil
          .sendGetRequest(path: url, params: {'threadId': threadId});
      if (res.statusCode == 200 || res.statusCode == 201) {
        List json = res.data;
        for (var value in json) {
          messages.add(Message.fromJson(value));
        }
        pp('$mm ... getThreadMessages messages found: ${messages.length}'
            ' ... put on message stream ... isQuestion: $isQuestion');
        for (var msg in messages) {
          pp('$mm message: ${msg.toJson()}');
        }
        if (isQuestion) {
          _questionController.sink.add(messages);
        } else {
          _msgController.sink.add(messages);
        }
        return messages;
      } else {
        pp('$mm ... getThreadMessages messages found: ZERO!!');
      }
    } catch (e, s) {
      pp('$mm  👿👿👿👿$e $s');
      throw Exception('Failed to create thread; error: $e');
    }

    return messages;
  }

  late Timer timer;

  void startPollingTimer(String threadId, String runId, bool isQuestion) {
    timer = Timer.periodic(Duration(seconds: 15), (timer) {
      pp('$mm timer tick #${timer.tick}');
      _pollThread(threadId, runId, isQuestion);
    });
  }

  Future<Run> _pollThread(
      String threadId, String runId, bool isQuestion) async {
    pp('$mm ... pollThread started ... runId: $runId threadId: $threadId');
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/checkRunStatus';

    late Run run;
    try {
      Response res = await dioUtil.sendGetRequest(
          path: url, params: {'runId': runId, 'threadId': threadId});
      if (res.statusCode == 200 || res.statusCode == 201) {
        run = Run.fromJson(res.data);
        if (run.status != null) {
          switch (run.status) {
            case Status.queued:
              pp('\n\n$mm Run status: ${Status.queued}');
              _statusController.sink.add(Status.queued.name);
              break;
            case Status.in_progress:
              pp('\n\n$mm Run status: ${Status.in_progress}');
              _statusController.sink.add(Status.in_progress.name);
              break;
            case Status.completed:
              pp('\n\n$mm Run status: 🥦🥦🥦 ${Status.completed} 🥦🥦🥦');
              _statusController.sink.add(Status.completed.name);
              timer.cancel();
              getThreadMessages(threadId: threadId, isQuestion: isQuestion);
              return run;
              break;
            case Status.cancelling:
              pp('\n\n$mm Run status: ${Status.cancelling}');
              _statusController.sink.add(Status.cancelling.name);
              break;
            case Status.cancelled:
              pp('\n\n$mm Run status: ${Status.cancelled}');
              _statusController.sink.add(Status.cancelled.name);
              timer.cancel();
              break;
            case Status.failed:
              pp('\n\n$mm Run status: ${Status.failed}');
              _statusController.sink.add(Status.failed.name);
              timer.cancel();
              break;
            case Status.expired:
              pp('\n\n$mm Run status: ${Status.expired}');
              _statusController.sink.add(Status.expired.name);
              timer.cancel();
              break;
            case Status.requires_action:
              pp('\n\n$mm Run status: ${Status.requires_action}');
              _statusController.sink.add(Status.requires_action.name);
              timer.cancel();
              break;
            case null:
              pp('$mm Run status is null');
              break;
          }
        }
        pp('\n\n$mm ... result from poll, run '
            'statusCode: 💛💛💛 ${res.statusCode} 💛💛💛');
      } else {
        pp('$mm FAILED: pollThread: statusCode: '
            '${res.statusCode} msg: ${res.statusMessage}');
        throw Exception(
            'Failed to run pollThread; status: ${res.statusCode} ${res.statusMessage}');
      }
    } catch (e, s) {
      pp('$mm  👿👿👿👿$e $s');
      throw Exception('Failed to get Run status: $e');
    }
    return run;
  }

  Future<List<OpenAIAssistant>> listAssistants() async {
    var url = '${ChatbotEnvironment.getGeminiUrl()}assistant/listAssistants';
    List<OpenAIAssistant> mList = [];
    try {
      Response res = await dioUtil.sendGetRequestWithHeaders(
          path: url, queryParameters: {}, headers: {});
      if (res.statusCode == 200) {
        List inList = res.data;
        for (var value in inList) {
          mList.add(OpenAIAssistant.fromJson(value));
        }
      } else {
        throw Exception(
            'Failed to list OpenAI assistants; statusCode: ${res.statusCode}');
      }
    } catch (e, s) {
      pp('$mm  👿👿👿👿$e $s');
      throw Exception('Failed to list OpenAI models; $e');
    }
    pp('$mm assistants listed: 🍎 ${mList.length} 🍎');

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
      pp('$mm  👿👿👿👿$e $s');
      throw Exception('Failed to list OpenAI models');
    }
    pp('$mm models listed: 🍎 ${mList.length} 🍎');
    return mList;
  }

  Future<File> downloadFile(String url, String fileName) async {
    try {
      var response = await http.get(Uri.parse(url));
      var bytes = response.bodyBytes;
      // Get the temporary directory path
      Directory tempDir = await getTemporaryDirectory();
      // Create the necessary directories if they don't exist
      String filePath = '${tempDir.path}/$fileName';
      await Directory(tempDir.path).create(recursive: true);

      // Write the file to the temporary directory
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      pp('\n\n$mm pdf file downloaded: 💛💛💛 ${(await file.length() / 1024).toStringAsFixed(2)}K bytes: 🍎File: $fileName');

      return file;
    } catch (e, s) {
      pp('$mm  👿👿👿👿Error downloading file: $e $s');
      rethrow;
    }
  }
}

const String generalInstructions = '''
Your name is SgelaAI and you are a Tutor and Assistant who will help me study and prepare for exams. 
You are friendly and very knowledgeable and expert in this subject: #SUBJECT. You will focus your responses on this subject.

You can scan uploaded exam paper document which contains multiple choice and descriptive questions. 
You return your responses in markdown format unless specifically requested to respond in json format.
''';

const String getQuestionsInstructions = '''
Please scan the uploaded document and find all questions.
Present them in a strict, valid JSON list that is required for automated processes downstream.

Use the following example of the JSON list expected as the response:

[
  {
    "fileName": "Business Studies Exam.pdf",
    "sectionName": "SECTION A",
    "subSectionName": "Something Here",
    "questionNumber": "1",
    "subQuestionNumber": "1.1",
    "questionText": "What is the primary goal of business management?",
    "subQuestionText": [
         "1.1.1 What are the tools used by the Federal Reserve in monetary policy?", 
         "1.1.2 How does the Federal Reserve influence interest rates?"
    ],
    "index": 1
  },
  {
    "fileName": "Business Studies Exam.pdf",
    "sectionName": "SECTION B",
    "subSectionName": "Economics Foundation",
    "questionNumber": "2",
    "subQuestionNumber": "2.1",
    "questionText": "Explain the role of the Federal Reserve.",
    "subQuestionText": [
      "2.1.1 What are the tools used by the Federal Reserve in monetary policy?", 
      "2.1.2 How does the Federal Reserve influence interest rates?"
      ],
    "index": 2
  }
]

Please REMEMBER that the valid JSON list is required for automated downstream processes and should not be truncated.
 ''';
const String studyPlanInstructions =
    ''' Generate a study or preparation plan ensure that the plan covers all the question topic areas in the document. 

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


Include at least 6 research links for each week

The schema to be used for the plan:
 [
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
    },
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

The plan should be over 6 weeks.
Please REMEMBER that the list is required for automated downstream processes and should not be truncated.
 ''';
