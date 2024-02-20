import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../data/sgela_user.dart';
import '../sgela_util/environment.dart';
import '../sgela_util/functions.dart';
import '../sgela_util/prefs.dart';
import 'firestore_service.dart';

class AuthService {
  static const String mm = '🍎🍎🍎 AuthService: ';

  final FirebaseAuth firebaseAuth;
  final Prefs prefs;
  final FirestoreService firestoreService;

  AuthService(this.firebaseAuth, this.prefs, this.firestoreService);

  Future<SgelaUser?> registerUser(SgelaUser user) async {
    pp('$mm create Firebase User ...');

    try {
      var creds = await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: 'pass123');
      if (creds.user != null) {
        user.firebaseUserId = creds.user?.uid;
        await firebaseAuth.currentUser!
            .updateDisplayName('${user.firstName} ${user.lastName}');
        var sgelaUser = await firestoreService.addSgelaUser(user);
        prefs.saveUser(sgelaUser);
        pp('$mm User added to Firebase/Firestore, saved in prefs: ${sgelaUser.toJson()}');
        return sgelaUser;
      }
    } catch (e, s) {
      pp(e);
      pp(s);
      throw Exception(
          'Unable to create authenticated user. Check your email address');
    }
    return null;
  }

  Future forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<SgelaUser?> signInUser(String email, String password) async {
    pp('$mm create Firebase User ...');

    var creds = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (creds.user == null) {
      throw Exception('Sign in failed');
    }
    pp('$mm Firebase User authenticated OK, ');

    var app = await Firebase.initializeApp(
      name: ChatbotEnvironment.getFirebaseName(),
      // options: DefaultFirebaseOptions.currentPlatform,
    );
    pp('$mm Getting the user from Firestore ... Firebase.initializeApp again. Why????');

    var sgelaUser = await firestoreService.getSgelaUser(creds.user!.uid);
    if (sgelaUser != null) {
      var sponsoree = await firestoreService.getSponsoree(creds.user!.uid);
      pp('$mm SgelaUser is signed in: ${sgelaUser.toJson()}');
      if ((sponsoree != null)) {
        pp('$mm Sponsoree found is: ${sponsoree.toJson()}');
        var org =
            await firestoreService.getOrganization(sponsoree.organizationId!);
        var brands = await firestoreService.getOrganizationBrandings(
            sponsoree.organizationId!, true);
      }

      return sgelaUser;
    } else {
      pp('$mm SgelaUser not found');
      throw Exception('SgelaAI user not found');
    }

    return null;
  }
}