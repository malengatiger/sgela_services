import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sgela_services/data/org_user.dart';

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

  Future<OrgUser?> signIn(String email, String password) async {
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

    var sgelaUser = await firestoreService.getOrgUser(creds.user!.uid);
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

  // Future<SgelaUser?> signIn(String email, String password) async {
  //   pp('$mm ... signing in with email: $email $password');
  //
  //   var mAuth = auth.FirebaseAuth.instance;
  //   var creds = await mAuth.signInWithEmailAndPassword(
  //       email: email, password: password);
  //   if (creds.user != null) {
  //     pp('$mm ... device user signed in: ${creds.user?.email} 🥬🥬 ${creds.user?.displayName}');
  //     var user = await firestoreService.getUser(creds.user!.uid);
  //     if (user != null) {
  //       pp('$mm ... getting all the basic data needed ..... user: ${user.toJson()}');
  //       prefs.saveUser(user);
  //       await firestoreService.getCountries();
  //       var org = await firestoreService.getOrganization(user.organizationId!);
  //       if (org != null) {
  //         pp('$mm ... getting all the basic data needed ..... organization: ${user.toJson()}');
  //         prefs.saveOrganization(org);
  //         if (org.country != null) {
  //           prefs.saveCountry(org.country!);
  //         }
  //         await firestoreService.getSponsorProducts(true);
  //         await firestoreService.getUsers(org.id!, true);
  //         var brandings = await firestoreService.getBranding(org.id!, true);
  //         String? logoUrl;
  //         if (brandings.isNotEmpty) {
  //           if (brandings.first.logoUrl != null) {
  //             logoUrl = brandings.first.logoUrl!;
  //           }
  //         }
  //         if (logoUrl != null) {
  //           prefs.saveLogoUrl(logoUrl);
  //         }
  //       }
  //       pp('$mm ... user signed in and org data cached!');
  //       return user;
  //     }
  //   }
  //   return null;
  // }

  // Future authenticateUser(SgelaUser user) async {
  //   pp('$mm ... createUserWithEmailAndPassword for new user ...');
  //   user.id = DateTime.now().millisecondsSinceEpoch;
  //   var creds = await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: user.email!, password: "pass123");
  //   if (creds.user != null) {
  //     user.firebaseUserId = creds.user!.uid;
  //     user.date = DateTime.now().toIso8601String();
  //     user.activeFlag = true;
  //     user.password = null;
  //
  //     firestoreService.addUser(user);
  //   }
  //   pp('$mm ... new user created, sending sign in email link ...user email: ${user.toJson()}');
  //   try {
  //     await auth.FirebaseAuth.instance.sendSignInLinkToEmail(
  //         email: user.email!,
  //         actionCodeSettings: _getActionCodeSettings(user.id!));
  //     pp('$mm ... authenticated and email sign in link sent: ${user.toJson()}');
  //   } catch (e) {
  //     pp(e);
  //   }
  // }

}
