import 'package:firebase_auth/firebase_auth.dart';
import 'package:sgela_services/data/organization.dart';
import 'package:sgela_services/data/sponsoree.dart';

import '../data/sgela_user.dart';
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

  Future<Sponsoree?> signInSponsoree(String email, String password) async {
    pp('$mm create Firebase User ...');

    var creds = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (creds.user == null) {
      throw Exception('Sign in failed');
    }
    pp('$mm Firebase User authenticated OK, ');

    var sponsoree = await firestoreService.getSponsoree(creds.user!.uid);
    if ((sponsoree != null)) {
      pp('$mm Sponsoree found is: ${sponsoree.toJson()}');
      var org =
          await firestoreService.getOrganization(sponsoree.organizationId!);
      var brands = await firestoreService.getOrganizationBrandings(
          sponsoree.organizationId!, true);
    }

    return sponsoree;
  }

  Future<Organization?> signInOrgUser(String email, String password) async {
    pp('$mm signIn Firebase User ...');

    var creds = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (creds.user == null) {
      throw Exception('Sign in failed');
    }
    pp('$mm Firebase User authenticated OK, ');

    var org = await firestoreService.getOrganizationByAdminUser(creds.user!.uid);
    if (org != null) {
      pp('$mm Organization is found: ${org.toJson()}');
      return org;
    } else {
      pp('$mm org not found');
      throw Exception('SgelaAI org not found');
    }
  }
  Future<SgelaUser?> signInSgelaUser(String email, String password) async {
    pp('$mm signIn Firebase User ...');

    var creds = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (creds.user == null) {
      throw Exception('Sign in failed');
    }
    pp('$mm Firebase User authenticated OK, ');

    var sgelaUser = await firestoreService.getSgelaUser(creds.user!.uid);
    if (sgelaUser != null) {
      pp('$mm SgelaUser is signed in: ${sgelaUser.toJson()}');
      return sgelaUser;
    } else {
      pp('$mm SgelaUser not found');
      throw Exception('SgelaAI user not found');
    }
  }

  bool isSignedIn() {
    if (firebaseAuth.currentUser == null) {
      return false;
    }
    firebaseAuth.authStateChanges().listen((user) async {
      if ((user != null)) {
        pp('authStateChanges, token: ${await user.getIdToken()}');
      }
    });
    return true;
  }
}
