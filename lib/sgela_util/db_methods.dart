
import 'package:get_it/get_it.dart';
import 'package:sgela_services/data/sponsoree.dart';
import 'package:sgela_services/services/firestore_service.dart';

import '../data/exam_link.dart';
import '../data/gemini_response_rating.dart';
import '../data/sponsoree_activity.dart';
import '../data/tokens_used.dart';
import 'functions.dart';

class DBMethods {

  static Future<AIResponseRating?> addRating(double rating, Sponsoree sponsoree,
      String aiModel, ExamLink examLink, int numberOfPages) async {
    pp('🥦🥦🥦 add rating for session ... ');
    FirestoreService firestoreService = GetIt.instance<FirestoreService>();
    try {
    AIResponseRating mr = AIResponseRating(
          aiModel: aiModel,
          organizationId: sponsoree.organizationId,
          sponsoreeId: sponsoree.id,
          sponsoreeName: sponsoree.sgelaUserName,
          sponsoreeEmail: sponsoree.sgelaEmail,
          sponsoreeCellphone: sponsoree.sgelaCellphone,
          subjectId: examLink.subjectId,
          subject: examLink.subject,
          id: DateTime.now().millisecondsSinceEpoch,
          rating: rating.toInt(),
          userId: sponsoree.sgelaUserId,
          examTitle:
          '${examLink.documentTitle} - ${examLink.title}',
          date: DateTime.now().toUtc().toIso8601String(),
          numberOfPagesInQuery: numberOfPages,
          examLinkId: examLink.id);

      pp('🥦🥦🥦 ....... add AIResponseRating to database ... ');
      await firestoreService.addRating(mr);
      pp('🥦🥦🥦 ... AIResponseRating added to database ... 🍎🍎\n'
          '🍎🍎 ${mr.toJson()}');

     return mr;
    } catch (e, s) {
      pp('ERROR: $e - $s');
    }
    return null;
  }

  static Future<TokensUsed?> addTokensUsed(int totalTokens, Sponsoree sponsoree, String model) async {
    TokensUsed? tokensUsed;
    try {
      pp('🥦🥦🥦 add tokens used in session ... ');
      FirestoreService firestoreService = GetIt.instance<FirestoreService>();

       tokensUsed = TokensUsed(organizationId: sponsoree.organizationId!,
          sponsoreeId: sponsoree.id!,
          date: DateTime.now().toUtc().toIso8601String(),
          sponsoreeName: sponsoree.sgelaUserName,
          organizationName: sponsoree.organizationName,
          model: model,
          totalTokens: totalTokens, promptTokens: 0, completionTokens: 0);
      firestoreService.addTokensUsed(tokensUsed);
      pp('🥦🥦🥦 tokens used in session and added to db: $totalTokens ...... '
          '🍎🍎\n🍎🍎${tokensUsed.toJson()} ');
    } catch (e, s) {
      pp("ERROR counting tokens: $e $s");
    }
    return tokensUsed;
  }

 static Future<SponsoreeActivity?> addSponsoreeActivity(String model, Sponsoree sponsoree,
      int totalTokens,
      ExamLink examLink,int elapsedTimeInSeconds) async {
   FirestoreService firestoreService = GetIt.instance<FirestoreService>();
   SponsoreeActivity? activity;
    try {
       activity = SponsoreeActivity(
          organizationId: sponsoree.organizationId,
          id: DateTime.now().millisecondsSinceEpoch,
          date: DateTime.now().toUtc().toIso8601String(),
          organizationName: sponsoree.organizationName,
          examLinkId: examLink.id,
          totalTokens: totalTokens,
          aiModel: model,
          elapsedTimeInSeconds: elapsedTimeInSeconds,
          sponsoreeCellphone: sponsoree.sgelaCellphone,
          sponsoreeEmail: sponsoree.sgelaEmail,
          sponsoreeName: sponsoree.sgelaUserName,
          subjectId:examLink.subjectId,
          examTitle:
          '${examLink.documentTitle} - ${examLink.title}',
          subject: examLink.subject,
          userId: sponsoree.sgelaUserId,
          sponsoreeId: sponsoree.id!);

      pp('🥦🥦🥦 ... add SponsoreeActivity to database ... ');
      pp(activity.toJson());
      await firestoreService.addSponsoreeActivity(activity);
      pp('🥦🥦🥦 ... SponsoreeActivity added to database ... ');
    } catch (e, s) {
      pp(e);
      pp(s);

    }
    return activity;
  }

}