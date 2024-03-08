import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:sgela_services/data/branding.dart';
import 'package:sgela_services/data/city.dart';
import 'package:sgela_services/data/country.dart';
import 'package:sgela_services/data/gemini_response_rating.dart';
import 'package:sgela_services/data/org_user.dart';
import 'package:sgela_services/data/organization.dart';
import 'package:sgela_services/data/sgela_product_details.dart';
import 'package:sgela_services/data/sponsor_product.dart';
import 'package:sgela_services/data/sponsoree.dart';
import 'package:sgela_services/data/subscription.dart';
import 'package:sgela_services/sgela_util/location_util_sp.dart';
import 'package:sgela_services/sgela_util/sponsor_prefs.dart';

import '../sgela_util/functions.dart';

class SponsorFirestoreService {
  final FirebaseFirestore firebaseFirestore;
  static const mm = '🌀🌀🌀🌀🌀FirestoreService 🌀';

  SponsorFirestoreService(this.firebaseFirestore) {
    firebaseFirestore.settings = const Settings(
      persistenceEnabled: true,
    );
  }

  List<Country> countries = [];
  Country? localCountry;

  Future<OrgUser> addUser(OrgUser user) async {
    var ref = await firebaseFirestore.collection('User').add(user.toJson());
    var m = ref.path;
    pp('$mm user added to database: ${user.toJson()}');
    return user;
  }

  Future<List<AIResponseRating>> getRatings(int examLinkId) async {
    List<AIResponseRating> ratings = [];
    var querySnapshot = await firebaseFirestore
        .collection('GeminiResponseRating')
        .where('examLinkId', isEqualTo: examLinkId)
        .get();
    for (var s in querySnapshot.docs) {
      var rating = AIResponseRating.fromJson(s.data());
      ratings.add(rating);
    }
    return ratings;
  }

  Future<Subscription?> addSubscription(Subscription subscription) async {
    pp('$mm addSubscription to be added to database: ${subscription.toJson()}');

    subscription.id = DateTime.now().millisecondsSinceEpoch;
    var colRef = firebaseFirestore.collection('Subscription');
    var docRef = await colRef.add(subscription.toJson());
    var v = await docRef.get();
    var doc = v.data();
    if (doc != null) {
      pp('$mm subscription added to database: $doc');
      return Subscription.fromJson(doc);
    }
    return null;
  }

  Future<SgelaProductDetails?> addSgelaProductDetails(
      SgelaProductDetails productDetails) async {
    pp('$mm addSubscription to be added to database: ${productDetails.toJson()}');

    //productDetails.id = DateTime.now().millisecondsSinceEpoch;
    var colRef = firebaseFirestore.collection('SgelaProductDetails');
    var docRef = await colRef.add(productDetails.toJson());
    var v = await docRef.get();
    var doc = v.data();
    if (doc != null) {
      pp('$mm subscription added to database: $doc');
      return SgelaProductDetails.fromJson(doc);
    }
    return null;
  }

  List<SponsorProduct> sponsorProducts = [];

  Future<List<SponsorProduct>> getSponsorProducts(bool refresh) async {
    var sponsorPrefs = GetIt.instance<SponsorPrefs>();

    var country = await getLocalCountry();
    if (refresh) {
      if (country != null) {
        pp('$mm ... get getSponsorProducts from Firestore ...');
        var qs = await firebaseFirestore
            .collection('SponsorPaymentType')
            .where('countryName', isEqualTo: country.name!)
            .get();
        sponsorProducts.clear();
        for (var snap in qs.docs) {
          sponsorProducts.add(SponsorProduct.fromJson(snap.data()));
        }
        pp('$mm ... sponsorProducts found in Firestore: ${sponsorProducts.length}');
        for (var t in sponsorProducts) {
          pp('$mm SponsorProduct: 🔵🔵🔵🔵 ${t.toJson()} 🔵🔵🔵🔵');
        }
        sponsorPrefs.saveSponsorProducts(sponsorProducts);
        return sponsorProducts;
      }
      pp('$mm ... SponsorProducts found in Firestore: ${sponsorProducts.length}');
    }
    sponsorProducts = sponsorPrefs.getSponsorProducts();
    if (sponsorProducts.isNotEmpty) {
      return sponsorProducts;
    } else {
      getSponsorProducts(true);
    }

    return sponsorProducts;
  }

  Future<List<Organization>> getOrganizations(bool refresh) async {

    List<Organization> orgs = [];
    if (refresh) {
      pp('$mm ... get getOrganizations from Firestore ...');
      var qs = await firebaseFirestore.collection('Organization').get();
      for (var snap in qs.docs) {
        orgs.add(Organization.fromJson(snap.data()));
      }
      pp('$mm ... orgs found in Firestore: ${orgs.length}');
      for (var t in orgs) {
        pp('$mm Organization: 🔵🔵🔵🔵 ${t.toJson()} 🔵🔵🔵🔵');
      }
    }

    return orgs;
  }
  Future<List<Branding>> getAllBrandings(bool refresh) async {

    List<Branding> orgs = [];
    if (refresh) {
      pp('$mm ... get getAllBrandings from Firestore ...');
      var qs = await firebaseFirestore.collection('Branding').get();
      for (var snap in qs.docs) {
        orgs.add(Branding.fromJson(snap.data()));
      }
      pp('$mm ... Brandings found in Firestore: ${orgs.length}');
      for (var t in orgs) {
        pp('$mm Branding: 🔵🔵🔵🔵 ${t.toJson()} 🔵🔵🔵🔵');
      }
    }

    return orgs;
  }
  Future<List<Country>> getCountries() async {
    var sponsorPrefs = GetIt.instance<SponsorPrefs>();

    countries.clear();
    pp('$mm ... get countries from Firestore ...');

    var qs = await firebaseFirestore.collection('Country').get();
    for (var snap in qs.docs) {
      countries.add(Country.fromJson(snap.data()));
    }
    pp('$mm ... countries found in Firestore: ${countries.length}');
    sponsorPrefs.saveCountries(countries);
    getLocalCountry();
    return countries;
  }

  Future<Country?> getLocalCountry() async {
    if (localCountry != null) {
      return localCountry!;
    }
    if (countries.isEmpty) {
      await getCountries();
    }
    var place = await LocationUtil.findNearestPlace();
    if (place != null) {
      for (var value in countries) {
        if (value.name!.contains(place.country!)) {
          localCountry = value;
          pp('$mm ... local country found: ${localCountry!.name}');
          break;
        }
      }
    }
    return localCountry;
  }

  Future<Organization?> getOrganization(int organizationId) async {
    pp('$mm ... getOrganization from Firestore ... organizationId: $organizationId');
    List<Organization> list = [];
    var qs = await firebaseFirestore
        .collection('Organization')
        .where('id', isEqualTo: organizationId)
        .get();
    for (var snap in qs.docs) {
      list.add(Organization.fromJson(snap.data()));
    }
    pp('$mm ... orgs found: ${list.length}');

    if (list.isNotEmpty) {
      return list.first;
    }
    return null;
  }

  Future<List<SgelaProductDetails>> getSgelaProductDetails(
      int organizationId) async {
    pp('$mm ... getSgelaProductDetails from Firestore ... organizationId: $organizationId');
    List<SgelaProductDetails> list = [];
    var qs = await firebaseFirestore
        .collection('SgelaProductDetails')
        .where('organizationId', isEqualTo: organizationId)
        .get();
    for (var snap in qs.docs) {
      list.add(SgelaProductDetails.fromJson(snap.data()));
    }
    pp('$mm ... products found: ${list.length}');

    if (list.isNotEmpty) {
      list.sort((a, b) => b.date!.compareTo(a.date!));
      return list;
    }
    return [];
  }

  Future<List<City>> getCities(int countryId) async {
    pp('$mm ... get cities from Firestore ... countryId: $countryId');
    List<City> cities = [];
    var qs = await firebaseFirestore
        .collection('City')
        .where('countryId', isEqualTo: countryId)
        .get();
    pp('$mm ... qs found: ${qs.size} cities');

    for (var snap in qs.docs) {
      cities.add(City.fromJson(snap.data()));
    }

    pp('$mm ... cities found: ${cities.length}');
    return cities;
  }

  Future<List<Branding>> getBranding(int organizationId, bool refresh) async {
    var sponsorPrefs = GetIt.instance<SponsorPrefs>();

    if (refresh) {
      pp('$mm ... get branding from Firestore ... organizationId: $organizationId');
      var qs = await firebaseFirestore
          .collection('Branding')
          .where('organizationId', isEqualTo: organizationId)
          .get();
      brandings.clear();
      for (var snap in qs.docs) {
        brandings.add(Branding.fromJson(snap.data()));
      }
      pp('$mm ... getBranding: brandings found: ${brandings.length}');
      brandings.sort((a, b) => b.date!.compareTo(a.date!));
      sponsorPrefs.saveBrandings(brandings);
      return brandings;
    }

    // brandings = prefs.getBrandings();
    return brandings;
  }

  List<Sponsoree> orgSponsorees = [];

  Future<List<Sponsoree>> getOrgSponsorees(
      int organizationId, bool refresh) async {
    if (refresh) {
      pp('$mm ... get branding from Firestore ... organizationId: $organizationId');
      var qs = await firebaseFirestore
          .collection('OrgSponsoree')
          .where('organizationId', isEqualTo: organizationId)
          .get();
      orgSponsorees.clear();
      for (var snap in qs.docs) {
        orgSponsorees.add(Sponsoree.fromJson(snap.data()));
      }
      pp('$mm ... OrgSponsorees found: ${orgSponsorees.length}');
      return orgSponsorees;
    }
    return orgSponsorees;
  }

  Future<int?> countOrgSponsorees(int organizationId) async {
    pp('$mm ... get branding from Firestore ... organizationId: $organizationId');
    var qs = await firebaseFirestore
        .collection('OrgSponsoree')
        .where('organizationId', isEqualTo: organizationId)
        .count()
        .get();

    return qs.count;
  }

  Future<List<Subscription>> getSubscriptions(int organizationId) async {
    pp('$mm ... getSubscriptions from Firestore ... organizationId: $organizationId');

    var qs = await firebaseFirestore
        .collection('Subscription')
        .where('organizationId', isEqualTo: organizationId)
        .get();
    List<Subscription> subs = [];
    for (var snap in qs.docs) {
      subs.add(Subscription.fromJson(snap.data()));
    }

    pp('$mm ... subs found: ${subs.length}');
    subs.sort((a, b) => b.date!.compareTo(a.date!));
    return subs;
  }

  Future<List<OrgUser>> getUsers(int organizationId, bool refresh) async {
    var sponsorPrefs = GetIt.instance<SponsorPrefs>();
    if (refresh) {
      // pp('$mm ... get users from Firestore ... organizationId: $organizationId');
      var qs = await firebaseFirestore
          .collection('User')
          .where('organizationId', isEqualTo: organizationId)
          .get();
      users.clear();
      for (var snap in qs.docs) {
        users.add(OrgUser.fromJson(snap.data()));
      }
      pp('$mm ... users found: ${users.length}');
      users.sort((a, b) => b.lastName!.compareTo(a.lastName!));
      sponsorPrefs.saveUsers(users);
      return users;
    }
    users = sponsorPrefs.getUsers();
    return users;
  }

  Future<OrgUser?> getUser(String firebaseUserId) async {
    pp('$mm ... get user from Firestore ... firebaseUserId: $firebaseUserId');

    var qs = await firebaseFirestore
        .collection('User')
        .where('firebaseUserId', isEqualTo: firebaseUserId)
        .get();
    users.clear();
    for (var snap in qs.docs) {
      users.add(OrgUser.fromJson(snap.data()));
    }

    pp('$mm ... users found: ${users.length}');
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  List<Branding> brandings = [];
  List<OrgUser> users = [];

// Future<List<SponsorProduct>> getSponsorProducts(bool refresh) async {
//   var country = await getLocalCountry();
//   if (refresh) {
//     if (country != null) {
//       pp('$mm ... get getSponsorProducts from Firestore ...');
//
//       var qs = await firebaseFirestore.collection('SponsorPaymentType')
//           .where('countryName', isEqualTo: country.name!)
//           .get();
//       sponsorProducts.clear();
//       for (var snap in qs.docs) {
//         sponsorProducts.add(SponsorProduct.fromJson(snap.data()));
//       }
//       pp('$mm ... sponsorProducts found in Firestore: ${sponsorProducts.length}');
//       for (var t in sponsorProducts) {
//         pp('$mm SponsorProduct: 🔵🔵🔵🔵 ${t.toJson()} 🔵🔵🔵🔵');
//       }
//       // prefs.saveSponsorProducts(sponsorProducts);
//       return sponsorProducts;
//     }
//     pp('$mm ... SponsorProducts found in Firestore: ${sponsorProducts.length}');
//   }
//   sponsorProducts = sponsorPrefs.getSponsorProducts();
//   if (sponsorProducts.isNotEmpty) {
//     return sponsorProducts;
//   } else {
//     getSponsorProducts(true);
//   }
//
//
//   return sponsorProducts;
// }
}
