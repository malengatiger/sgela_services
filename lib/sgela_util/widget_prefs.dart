import 'dart:convert';

import 'package:sgela_services/data/branding.dart';
import 'package:sgela_services/data/country.dart';
import 'package:sgela_services/data/holder.dart';
import 'package:sgela_services/data/org_user.dart';
import 'package:sgela_services/data/organization.dart';
import 'package:sgela_services/data/sponsor_product.dart';
import 'package:sgela_services/sgela_util/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WidgetPrefs {
  final SharedPreferences sharedPreferences;
  static const mm = '🍀🍀🍀🍀🍀🍀 Prefs 🍀🍀';

  WidgetPrefs(this.sharedPreferences);
  //
  saveBrandings(List<Branding> brandings) {
    List<Map<String, dynamic>> brandingStrings =
    brandings.map((pm) => pm.toJson()).toList();
    List<String> brandingJsonStrings =
    brandingStrings.map((pm) => json.encode(pm)).toList();
    sharedPreferences.setStringList('brandings', brandingJsonStrings);
    pp('$mm ... brandings saved OK: ${brandings.length}');
  }

  // List<Branding> getBrandings() {
  //   List<String>? brandingJsonStrings =
  //   sharedPreferences.getStringList('brandings');
  //   if (brandingJsonStrings != null) {
  //     List<Branding> brandings = brandingJsonStrings
  //         .map((pmJson) => Branding.fromJson(json.decode(pmJson)))
  //         .toList();
  //     pp('$mm ... brandings retrieved: ${brandings.length}');
  //
  //     return brandings;
  //   } else {
  //     return [];
  //   }
  // }

  saveSponsorProducts(List<SponsorProduct> sponsorProducts) {
    List<Map<String, dynamic>> productStrings =
    sponsorProducts.map((pm) => pm.toJson()).toList();
    List<String> productJsonStrings =
    productStrings.map((pm) => json.encode(pm)).toList();
    sharedPreferences.setStringList('products', productJsonStrings);
    pp('$mm sponsorProducts saved : ${sponsorProducts.length}');

  }

  List<SponsorProduct> getSponsorProducts() {
    List<String>? sponsorProductJsonStrings =
    sharedPreferences.getStringList('products');
    if (sponsorProductJsonStrings != null) {
      List<SponsorProduct> sponsorProducts = sponsorProductJsonStrings
          .map((pmJson) => SponsorProduct.fromJson(json.decode(pmJson)))
          .toList();
      pp('$mm sponsorProducts retrieved: ${sponsorProducts.length}');

      return sponsorProducts;
    } else {
      return [];
    }
  }
  //
  saveCountries(List<Country> countries) {
    List<Map<String, dynamic>> countryStrings =
    countries.map((pm) => pm.toJson()).toList();
    List<String> countryJsonStrings =
    countryStrings.map((pm) => json.encode(pm)).toList();
    sharedPreferences.setStringList('countries', countryJsonStrings);
  }

  List<Country> getCountries() {
    List<String>? countryJsonStrings =
    sharedPreferences.getStringList('countries');
    if (countryJsonStrings != null) {
      List<Country> countries = countryJsonStrings
          .map((pmJson) => Country.fromJson(json.decode(pmJson)))
          .toList();
      pp('$mm countries retrieved: ${countries.length}');

      return countries;
    } else {
      return [];
    }
  }
  //
  saveBranding(List<Branding> brandings) {
    List<Map<String, dynamic>> brandingStrings =
    brandings.map((pm) => pm.toJson()).toList();
    List<String> brandingJsonStrings =
    brandingStrings.map((pm) => json.encode(pm)).toList();
    sharedPreferences.setStringList('brandings', brandingJsonStrings);
    pp('$mm brandings saved : ${brandings.length}');

  }

  List<Branding> getBrandings() {
    List<String>? brandingJsonStrings =
    sharedPreferences.getStringList('brandings');
    if (brandingJsonStrings != null) {
      List<Branding> brandings = brandingJsonStrings
          .map((pmJson) => Branding.fromJson(json.decode(pmJson)))
          .toList();
      pp('$mm brandings retrieved: ${brandings.length}');
      return brandings;
    } else {
      return [];
    }
  }
  //
  saveUsers(List<OrgUser> users) {
    List<Map<String, dynamic>> userStrings =
    users.map((pm) => pm.toJson()).toList();
    List<String> userJsonStrings =
    userStrings.map((pm) => json.encode(pm)).toList();
    sharedPreferences.setStringList('users', userJsonStrings);
  }

  List<OrgUser> getUsers() {
    List<String>? userJsonStrings =
    sharedPreferences.getStringList('users');
    if (userJsonStrings != null) {
      List<OrgUser> users = userJsonStrings
          .map((pmJson) => OrgUser.fromJson(json.decode(pmJson)))
          .toList();
      pp('$mm users retrieved: ${users.length}');
      return users;
    } else {
      return [];
    }
  }
  // Save the list of PaymentMethod to SharedPreferences
  savePaymentMethods(List<PaymentMethod> paymentMethods) {
    List<Map<String, dynamic>> paymentMethodStrings =
    paymentMethods.map((pm) => pm.toJson()).toList();
    List<String> paymentMethodJsonStrings =
    paymentMethodStrings.map((pm) => json.encode(pm)).toList();
    sharedPreferences.setStringList('paymentMethods', paymentMethodJsonStrings);
  }

// Retrieve the list of PaymentMethod from SharedPreferences
  List<PaymentMethod> getPaymentMethods() {
    List<String>? paymentMethodJsonStrings =
    sharedPreferences.getStringList('paymentMethods');
    if (paymentMethodJsonStrings != null) {
      List<PaymentMethod> paymentMethods = paymentMethodJsonStrings
          .map((pmJson) => PaymentMethod.fromJson(json.decode(pmJson)))
          .toList();
      return paymentMethods;
    } else {
      return [];
    }
  }

  void saveUser(OrgUser user) {
    Map mJson = user.toJson();
    var jx = json.encode(mJson);
    sharedPreferences.setString('user', jx);
    pp('$mm user saved ');

  }

  OrgUser? getUser() {
    var string = sharedPreferences.getString('user');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var user = OrgUser.fromJson(jx);
    pp('$mm user retrieved: ${user.toJson()}');
    return user;
  }

  void saveCountry(Country country) {
    Map mJson = country.toJson();
    var jx = json.encode(mJson);
    sharedPreferences.setString('country', jx);
    pp('$mm country saved ${country.name}');

  }

  Country? getCountry() {
    var string = sharedPreferences.getString('country');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var country = Country.fromJson(jx);
    pp('$mm country retrieved: ${country.name}');
    return country;
  }

  void saveCustomer(Customer customer) {
    Map mJson = customer.toJson();
    var jx = json.encode(mJson);
    sharedPreferences.setString('customer', jx);
  }

  Customer? getCustomer() {
    var string = sharedPreferences.getString('customer');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var c = Customer.fromJson(jx);
    return c;
  }

  void saveOrganization(Organization organization) {
    Map mJson = organization.toJson();
    var jx = json.encode(mJson);
    sharedPreferences.setString('Organization', jx);
    pp('$mm organization saved : ${organization.name}');

  }

  Organization? getOrganization() {
    var string = sharedPreferences.getString('Organization');
    if (string == null) {
      pp('$mm organization NOT FOUND!!!');
      return null;
    }
    var jx = json.decode(string);
    var org = Organization.fromJson(jx);
    pp('$mm organization retrieved: ${org.name}');

    return org;
  }

  void saveMode(int mode) {
    sharedPreferences.setInt('mode', mode);
  }

  int getMode() {
    var mode = sharedPreferences.getInt('mode');
    if (mode == null) {
      return -1;
    }
    return mode;
  }

  void saveColorIndex(int index) {
    sharedPreferences.setInt('color', index);
  }

  int getColorIndex() {
    var color = sharedPreferences.getInt('color');
    if (color == null) {
      return 0;
    }
    return color;
  }

  void saveLogoUrl(String logoUrl) {
    sharedPreferences.setString('logoUrl', logoUrl);
    pp('$mm logoUrl saved ');

  }

  String? getLogoUrl() {
    var url = sharedPreferences.getString('logoUrl');
    pp('$mm logoUrl retrieved: $url');

    return url;
  }
}