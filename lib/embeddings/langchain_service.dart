import 'package:langchain/langchain.dart';

import '../data/exam_link.dart';

abstract class LangChainService {
  Future<void> updatePineConeIndex(String indexName, List<Document> docs, String subject);
  Future<String> queryPineConeVectorStore(String indexName, String query);
  Future buildEmbeddings(ExamLink examLink);
}
