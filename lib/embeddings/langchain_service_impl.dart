import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:langchain_pinecone/langchain_pinecone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinecone/pinecone.dart';
import 'package:sgela_services/data/exam_link.dart';
import 'package:sgela_services/services/firestore_service.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/functions.dart';

import '../data/create_index_response.dart';
import '../data/exam_page_content.dart';
import '../sgela_util/http_utility.dart';
import 'langchain_service.dart';

class LangChainServiceImpl implements LangChainService {
  late PineconeClient pineConeClient;
  late Pinecone pineCone;
  late OpenAIEmbeddings openAIEmbeddings;
  late OpenAI openAI;
  late String indexName;
  final DioUtil dioUtil;

  static const mm = '🥦🥦🥦 LangChainServiceImpl 🥦🥦🥦';
  late String pineConeApiKey;
  late String environment;
  late String openAIApiKey;
  late String pineconeUrl, pineconeCloud, pineconeRegion;

  LangChainServiceImpl(this.dioUtil);

  void init() async {
    try {
      pp('$mm init ... constructing the LangChainService ... ');
      await dotenv.load();
      pineConeApiKey = dotenv.env['PINECONE_API_KEY']!;
      environment = dotenv.env['PINECONE_ENVIRONMENT']!;
      openAIApiKey = dotenv.env['OPEN_API_KEY']!;

      //pinecode goods:
      pineconeUrl = dotenv.env['PINECONE_URL']!;
      pineconeCloud = dotenv.env['PINECONE_CLOUD']!;
      pineconeRegion = dotenv.env['PINECONE_REGION']!;

      //
      pp('\n\n$mm init ...  LangChainService environment keys: 💛💛💛💛'
          '\n🍎🍎pineConeApiKey: $pineConeApiKey '
          '\n🍎🍎environment: $environment '
          '\n🍎🍎pineconeUrl: $pineconeUrl '
          '\n🍎🍎pineconeCloud: $pineconeCloud '
          '\n🍎🍎pineconeRegion: $pineconeRegion '
          '\n🍎🍎openAIApiKey: $openAIApiKey 💛💛💛💛 \n\n');

      pineConeClient = PineconeClient(
        apiKey: pineConeApiKey,
        baseUrl: pineconeUrl,
      );
      pp('\n$mm pineconeClient baseUrl: ${pineConeClient.baseUrl}');

      openAIEmbeddings = OpenAIEmbeddings(
        apiKey: openAIApiKey,
        client: http.Client(),
      );

      openAI = OpenAI(
        apiKey: openAIApiKey,
      );
      pp('$mm ... finished openAIEmbeddings: ${openAIEmbeddings.model} - ${openAIEmbeddings.apiKey}');
      pp('$mm ... finished constructing the LangChainService!');
    } catch (e, s) {
      pp('$mm $e - $s');
    }
  }

  static const vectorDimension = 1536;

  void setIndexName(String indexName) {
    pineCone = Pinecone(
      apiKey: pineConeApiKey,
      indexName: indexName,
      embeddings: openAIEmbeddings,
      environment: environment,
    );
  }

  List<PineconeIndex> indexes = [];

  Future<bool> _createAndUploadPineConeIndex(
      {required ExamLink examLink, required String indexName}) async {
    var start = DateTime.now();
    FirestoreService firestoreService = GetIt.instance<FirestoreService>();
    try {
      PineconeIndex pineconeIndex = await _buildServerlessIndex(indexName);
      pp('\n\n$mm PineconeIndex $indexName created: ${pineconeIndex.toJson()}');
      pineconeIndex.examLinkId = examLink.id!;
      pineconeIndex.subject = examLink.subject?.title;
      pineconeIndex.subjectId = examLink.subject?.id;
      pineconeIndex.examTitle = '${examLink.documentTitle} ${examLink.title}';

      await firestoreService.addPineconeIndex(pineconeIndex);
      pp('$mm PineconeIndex $indexName added to Firestore: ${pineconeIndex.toJson()}  ✅ ✅');

      await _getIndexes();
      //
      final docs = await _fetchDocumentsForLoading(examLink.id!);
      await updatePineConeIndex(
          pineconeIndex.name!, docs, examLink.subject!.title!);

      var end = DateTime.now();
      pp('\n\n\n$mm ... _createAndUploadPineConeIndex completed: '
          'elapsed: ${end.difference(start).inSeconds} seconds');
      _printIndexes();
      pp('\n\n\n');
      return true;
    } catch (e, s) {
      pp('$mm $e $s');
      rethrow;
    }
  }

  List<PineconeIndex> pinecodeIndexes = [];
  Future<void> _getIndexes() async {
    var resp =
        await HttpUtility.get(url: '$pineconeUrl/indexes', headers: headers);
    pp(resp.body);
    if (resp.statusCode == 200) {
      var dyn = jsonDecode(resp.body);
      List mJson = dyn['indexes'];
      for (var value in mJson) {
        indexes.add(PineconeIndex.fromJson(value));
      }
    }
    pp('$mm ... _getIndexes : ${indexes.length} indexes from Pinecone found');
    for (var ix in indexes) {
      pp('$mm index from Pinecone: 💛💛${ix.toJson()}');
    }
    //
    FirestoreService firestoreService = GetIt.instance<FirestoreService>();
    pinecodeIndexes = await firestoreService.getPineconeIndexes();
    // pp('$mm 🍎🍎indexes from Firestore: 🍎🍎${pinecodeIndexes.length} 🍎🍎\n');
    //
    // for (var ix in pinecodeIndexes) {
    //   pp('$mm 🍎🍎index from Firestore: 🍎🍎${ix.toJson()} 🍎🍎\n');
    // }
  }

  Future<List<Document>> _fetchDocumentsForLoading(int examLinkId) async {
    try {
      final textFilePathFromPdf = await _getExamPdfText(examLinkId);
      final loader = TextLoader(textFilePathFromPdf);
      final documents = await loader.load();
      pp('$mm documents loaded :  ${documents.length}');
      for (var doc in documents) {
        pp('$mm document created by TextLoader, id:  🔵${doc.id}');
      }

      return documents;
    } catch (e) {
      throw Exception('Error creating pinecone documents');
    }
  }

  Future<String> _getExamPdfText(int examLinkId) async {
    try {
      // Load the PDF document.
      FirestoreService firestoreService = GetIt.instance<FirestoreService>();
      List<ExamPageContent> contents =
          await firestoreService.getExamPageContents(examLinkId);
      pp('$mm exam pages: ${contents.length}, will create index ...');

      var sb = StringBuffer();
      for (var c in contents) {
        if (c.text != null) {
          var m = c.text!.replaceAll('Copyright reserved', '');
          sb.write('$m\n');
        }
      }

      String text = sb.toString();
      final localPath = await _localPath;
      File file = File('$localPath/pdfText.txt');
      final res = await file.writeAsString(text);
      pp('$mm exam pages unpacked, file length: ${await file.length()} bytes ...');
      return res.path;
    } catch (e) {
      throw Exception('Error converting pdf to text');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Map<String, String> headers = {};

  _buildHeaders() {
    headers = {
      // "Accept": 'application/json',
      'content-type': 'application/json',
      'Api-Key': pineConeApiKey,
    };
  }

  Future<PineconeIndex> _buildServerlessIndex(String indexName) async {
    _buildHeaders();
    Map<String, Object> body = {
      "name": indexName,
      "dimension": vectorDimension,
      "metric": "cosine",
      "spec": {
        "serverless": {"cloud": pineconeCloud, "region": pineconeRegion}
      }
    };
    pp('\n\n$mm build Pinecone Serverless index : $indexName at $pineconeUrl');
    pp('$mm ...headers: $headers');
    pp('$mm ... body: $body \n');

    try {
      http.Response response = await HttpUtility.post(
          url: '$pineconeUrl/indexes', body: body, headers: headers);
      pp('$mm response from pinecone, statusCode: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm GOOD response from pinecone: ${response.body}');
        //todo - get the host
        PineconeIndex cr = PineconeIndex.fromJson(jsonDecode(response.body));
        return cr;
      } else {
        pp('$mm Bad response status:  👿${response.statusCode}  👿${response.reasonPhrase} '
            ' 👿 👿 body: ${response.body}');
        throw Exception('unable to create Pinecone Serverless index');
      }
    } catch (e, s) {
      pp('$mm _buildServerlessIndex failed: $e \n$s');
      rethrow;
    }
  }

  @override
  Future<String> queryPineConeVectorStore(
      String indexName, String query) async {
    pp('$mm queryPineConeVectorStore: index: $indexName - query: $query');
    _buildHeaders();
    try {
      final index = await _describeIndex(indexName);
      if (index == null) {
        throw Exception('Pinecone index $indexName not found');
      }

      String url = 'https://${index.host}/query';
      pp('$mm queryPineConeVectorStore  🍎🍎 openAIEmbeddings.embedQuery about to be called ...');

      final queryEmbedding = await openAIEmbeddings.embedQuery(query);

      pp('$mm queryPineConeVectorStore index: 🍎🍎 ${index.name} '
          'openAIEmbeddings.embedQuery found, queryEmbedding.length: ${queryEmbedding.length}');

      var queryRequest = QueryRequest(
        topK: 20,
        vector: queryEmbedding,
        includeMetadata: true,
        includeValues: true,
      );

      pp('$mm body is queryRequest: 🍎🍎 ${queryRequest.toJson()} ');

      var resp = await HttpUtility.post(
          url: url, body: queryRequest.toJson(), headers: headers);
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        pp('$mm pineConeClient.queryVectors status: 🍎🍎 '
            '✅${resp.statusCode} \n🍎🍎body: ${resp.body} ✅');

        var queryResponse = QueryResponse.fromJson(jsonDecode(resp.body));
        if (queryResponse.matches.isNotEmpty) {
          pp('$mm queryResponse.matches.isNotEmpty: 🍎 ${queryResponse.matches.length} 🍎 ');

          final concatPageContent = queryResponse.matches.map((vectorMatch) {
            if (vectorMatch.metadata == null) return '';
            // check if the metadata has a 'pageContent' key
            if (vectorMatch.metadata!.containsKey('pageContent')) {
              var content = vectorMatch.metadata!['pageContent'];
              pp('\n\n$mm return vectorMatch.metadata pageContent: 🍎🍎\n $content');
              return content;
            } else {
              return '';
            }
          }).join(' ');

          pp('$mm StuffDocumentsQAChain and then send query to LLM: '
              '$query 🍎🍎 ... call chain!');

          final promptTemplate = ChatPromptTemplate.fromTemplates([
            (
              ChatMessageType.system,
              "You are a helpful AI assistant and you are good at finding questions in text."
            ),
            (
              ChatMessageType.human,
              'Help me extract questions from text and producing a list'
            ),
          ]);
          final docChain =
              StuffDocumentsQAChain(llm: openAI, prompt: promptTemplate);
          final response = await docChain.call({
            'input_documents': [Document(pageContent: concatPageContent)],
            'question': query,
          });

          pp('\n\n$mm .... docChain.call response: 🔴🔵 $response  🔴🔵\n\n');
          return response['output'];
        } else {
          return 'No results found';
        }
      } else {
        pp('$mm ERROR statusCode: ${resp.statusCode} - ${resp.body}');
        throw Exception(
            'Something fell downstairs, Boss! statusCode: ${resp.statusCode}');
      }
    } catch (e, s) {
      pp('$mm queryPineConeVectorStore: ERROR: $kk $e $s $kk');
      throw Exception('Error querying pinecone index');
    }
  }

  List<List<double>> embeddingArrays = [];

  @override
  Future<void> updatePineConeIndex(
      String indexName, List<Document> docs, String subject) async {
    try {
      pp("\n\n$mm updatePineConeIndex: Retrieving Pinecone index for update with ${docs.length} docs ...");
      PineconeIndex? index = await _describeIndex(indexName);
      for (final doc in docs) {
        pp('$mm updatePineConeIndex: Processing document: ${doc.metadata['source']}');
        final txtPath = doc.metadata['source'] as String;
        final text = doc.pageContent;

        const textSplitter = RecursiveCharacterTextSplitter(chunkSize: 1000, chunkOverlap: 200);
        final chunks = textSplitter.createDocuments([text]);

        pp('$mm ... Calling OpenAI\'s Embedding endpoint documents with ${chunks.length} text chunks ...');
        pp('$mm updatePineConeIndex: ... embedding documents; chunks: ${chunks.length}');
        final embeddingArrays = await openAIEmbeddings.embedDocuments(chunks);
        pp('$mm updatePineConeIndex: ... embedding documents; embeddingArrays: ${embeddingArrays.length}');
        if (embeddingArrays.isEmpty) {
          pp('$mm ERROR:  👿 👿 embeddingArrays not created, isEmpty!!  👿 👿');
          throw Exception('No embeddingArrays created');
        } else {
          pp('$mm updatePineConeIndex: 🔵🔵🔵 ... Creating ${chunks.length} '
              'vectors array with id, values, and metadata...');

          await _processChunksInBatches(
              chunks: chunks,
              embeddingArrays: embeddingArrays,
              txtPath: txtPath,
              index: index!,
              subject: subject);
        }
      }
    } catch (e, s) {
      pp('$mm $e - $s');
      rethrow;
    }
  }

  PineconeIndex? pineconeIndex;
  List<Document> mDocs = [];

  Future<PineconeIndex?> _describeIndex(String indexName) async {
    var url = '$pineconeUrl/indexes/$indexName';
    var resp = await HttpUtility.get(url: url, headers: headers);
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      pineconeIndex = PineconeIndex.fromJson(jsonDecode(resp.body));
      pp('$mm Pinecone index retrieved: ${pineconeIndex!.toJson()}');
    } else {
      pp('$mm Pinecone index retrieval failed: ${resp.statusCode} - ${resp.body}');
      throw Exception('Failed to get Pinecone index: $indexName');
    }
    return pineconeIndex;
  }

  Future<void> _processChunksInBatches(
      {required List<Document> chunks,
      required List<List<double>> embeddingArrays,
      required String txtPath,
      required PineconeIndex index,
      required String subject}) async {
    final batchSize = 10;
    for (int i = 0; i < chunks.length; i += batchSize) {
      List<Document> batch = chunks.sublist(
          i, i + batchSize > chunks.length ? chunks.length : i + batchSize);
      pp('$mm  Process the batch of documents and make vectors: ${batch.length} items in batch');
      embeddingArrays = await openAIEmbeddings.embedDocuments(batch);
      _makeChunkVectors(
          chunks: batch,
          embeddingArrays: embeddingArrays,
          txtPath: txtPath,
          index: index,
          subject: subject);
    }
    //send vectors ...
    List mBody = [];
    for (var vector in chunkVectors) {
      mBody.add(vector.toJson());
    }
    var body = {
      'vectors': mBody,
      'namespace': subject.toLowerCase().replaceAll(' ', '-')
    };
    try {
      var upserted = await _sendVectors(index, body);
      pp('\n\n$mm Pinecone index ${index.name} updated with $upserted vectors\n\n');
    } catch (e, s) {
      pp('$mm $e $s');
      rethrow;
    }
  }

  List<Vector> chunkVectors = [];

  Future _makeChunkVectors(
      {required List<Document> chunks,
      required List<List<double>> embeddingArrays,
      required String txtPath,
      required PineconeIndex index,
      required String subject}) async {
    pp('$mm make sure that these counts are the same; 🍎🍎'
        'chunks: ${chunks.length} embeddingArrays: ${embeddingArrays.length}');

    for (int i = 0; i < chunks.length; i++) {
      final chunk = chunks[i];
      final embeddingArray = embeddingArrays[i];
      final chunkVector = Vector(
          id: 'vec${DateTime.now().millisecondsSinceEpoch}',
          values: embeddingArray,
          metadata: {
            'pageContent': validateAsciiString(chunk.pageContent),
            'subject': subject.toLowerCase().replaceAll(' ', '-'),
          });

      chunkVectors.add(chunkVector);
    }
  }

  Future<int> _sendVectors(
      PineconeIndex index, Map<String, Object> body) async {
    pp('$mm _sendVectors: ...... vectors to be sent for index:'
        ' ${index.name},  🔵🔵🔵 vectors: ${body.length} 🔵🔵🔵\n\n');
    _buildHeaders();

    String url = 'https://${index.host}/vectors/upsert';
    try {
      pp('$mm ... sending vectors to Pinecone backend ...');
      var res = await HttpUtility.post(url: url, body: body, headers: headers);
      if (res.statusCode == 200 || res.statusCode == 201) {
        pp('\n\n$mm _sendVectors: GOOD RESPONSE:  ✅✅✅✅✅✅ '
            'statusCode: ${res.statusCode} ✅body: ${res.body}  ✅');
        var obj = jsonDecode(res.body);
        return obj['upsertedCount'] as int;
      } else {
        pp('\n\n$mm _sendVectors: BAD RESPONSE:  $kk'
            'statusCode: ${res.statusCode} \n '
            '$kk body: ${res.body} 👿reasonPhrase: ${res.reasonPhrase} 👿👿\n\n');
        throw Exception(
            'Sending vectors failed; statusCode: ${res.statusCode} ${res.reasonPhrase} - ');
      }
    } catch (e, s) {
      pp('$mm $e - $s');
      rethrow;
    }
  }

  String validateAsciiString(String text) {
    StringBuffer validTextBuffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      int charCode = text.codeUnitAt(i);
      if (charCode < 128) {
        validTextBuffer.writeCharCode(charCode);
      }
    }

    return validTextBuffer.toString();
  }

  static const kk = '👿👿👿👿';

  @override
  Future<bool> buildEmbeddings(ExamLink examLink) async {
    pp('\n\n\n$mm buildEmbeddings: check Exam Paper Embeddings '
        'for:  🔵${examLink.subject?.title} '
        ': ${examLink.documentTitle} ${examLink.title}');

    String indexName = 'exam${examLink.id}';
    try {
      await _getIndexes();
      _printIndexes();
      bool found = await _findIndex(indexName);
      if (found) {
        pp('\n$mm Embeddings have already been created for 💠💠${examLink.subject?.title} '
            ': ${examLink.documentTitle} ${examLink.title}\n\n');
        return true;
      }
      pp('\n\n$mm ... create pinecone embeddings index: $indexName .....');
      var m = await _createAndUploadPineConeIndex(
          examLink: examLink, indexName: indexName);
      return m;
    } catch (e, s) {
      pp('$mm $e $s');
      rethrow;
    }
  }

  _printIndexes() async {
    pp('\n\n\n$mm 🔵🔵🔵 🍎existing Pinecone indices: 🍎 ${indexes.length} 🍎');
    for (var ix in pinecodeIndexes) {
      pp('$mm 🔵🔵🍎 pinecone index: ${ix.name} 🔵 ${ix.subject} - ${ix.examTitle} 🍎');
    }
  }

  Future<bool> _findIndex(String indexName) async {
    bool found = false;
    for (var ix in pinecodeIndexes) {
      if (ix.name == indexName) {
        found = true;
      }
    }
    return found;
  }
}
