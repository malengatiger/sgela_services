// import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:sgela_services/data/exam_link.dart';
// import 'package:sgela_services/data/exam_page_content.dart';
// import 'package:sgela_services/services/firestore_service.dart';
// import 'package:get_it/get_it.dart';
// import 'package:sgela_services/sgela_util/environment.dart';

/*
1. PDF Library
2. Read PDF
3. Chunk PDF into paragraphs
4. Create vectors from paragraphs
5. Store vectors in database
6. Use db, search etc.
 */
class EmbeddingService {

  // Future getEmbedding(ExamLink examLink) async {
  //
  //   FirestoreService firestoreService = GetIt.instance<FirestoreService>();
  //   List<ExamPageContent> pageContents = await firestoreService.getExamPageContents(examLink.id!);
  //
  //   final apiKey = Platform.environment['GOOGLE_API_KEY'];
  //   if (apiKey == null) {
  //     stderr.writeln(r'No $GOOGLE_API_KEY environment variable');
  //     exit(1);
  //   }
  //   final model = GenerativeModel(model: 'embedding-001', apiKey: apiKey);
  //   final prompt = 'The quick brown fox jumps over the lazy dog.';
  //   print('Content: $prompt');
  //   final content = Content.text(prompt);
  //
  //   final result = await model.embedContent(content);
  //   print('Embedding:');
  //   print(result.embedding.values);
  // }

}
void main() async {
  final apiKey = 'AIzaSyAUXc8lM1wPsR-Rrow0XLms3iTbok7FjDA';
  final model = GenerativeModel(model: 'embedding-001', apiKey: apiKey);
  final prompt = ''' 
  History/P2 6 DBE/2023  SC/NSC – Addendum   QUESTION 2: WAS THE TRUTH AND RECONCILIATION COMMISSION (TRC)   SUCCESSFUL IN ATTAINING ITS AIMS WITH ARCHBISHOP DESMOND TUTU AS ITS CHAIRPERSON?  SOURCE 2A    The source below has been taken from an online newspaper article titled 'World Leaders Mourn Archbishop Desmond Tutu in Acknowledgement of Services Rendered to Imperialism: Sanitising the Crimes of Apartheid', by Professor Jean Shaoul on 5 January 2022. It explains Tutu's contribution as chairperson of the Truth and Reconciliation Commission (TRC).  Nelson Mandela, the first democratic South African president, chose Archbishop Tutu   to chair the commission. Set up in 1996, its purpose was to head off (prevent) popular demands for the trials of those responsible for the deaths and torture of tens of thousands of black workers and youth under apartheid.  Tutu called for reconciliation with the perpetrators of truly horrendous (horrific) crimes, with victims and perpetrators describing the cold-blooded details of torture and assassination (political murders). The Commission catalogued (recorded) atrocities (political killings) including the Sharpeville Massacre in 1960, the killings in Soweto in 1976 and in Langa in 1985, and the death squads in the notorious (well-known) Vlakplaas camp. It concluded that the ruling National Party government and its security forces were responsible for the majority of human rights abuses, backed by big business and supported by the judiciary (judges), the media and the church.   The introduction to the TRC's five-volume report, published in 1998, confirmed that the increasingly brutal imposition (forcing) of apartheid was motivated primarily by fear of social revolution, dressed up as the 'communist threat' in Africa; that the decision to end apartheid and bring the ANC to power was aimed at staving (preventing) off mass revolution by South Africa's workers and youth; and that the path taken by the ANC was designed to prevent such a revolution. Tutu said, 'Had the miracle of the negotiated settlement not occurred, we would have been overwhelmed by the bloodbath that virtually everyone predicted as the inevitable ending for South Africa.'  [From 'World Leaders Mourn Archbishop Desmond Tutu in Acknowledgement of Services Rendered to Imperialism: Sanitising the Crimes of Apartheid' by J Shaoul]  Copyright reserved  Please turn over
  ''';
  print('Content: $prompt');
  final content = Content.text(prompt);

  final result = await model.embedContent(content);
  print('Embedding:');
  print(result.embedding.values);
}