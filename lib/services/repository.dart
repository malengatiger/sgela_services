import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:sgela_services/services/firestore_service_sponsor.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/environment.dart';
import 'package:sgela_services/sgela_util/functions.dart';
import 'package:sgela_services/sgela_util/sponsor_prefs.dart';
import 'package:sgela_services/services/rapyd_payment_service.dart';

import 'package:sgela_services/data/organization.dart';
import 'package:sgela_services/data/branding.dart';

class RepositoryService {
  final DioUtil dioUtil;
  final SponsorFirestoreService firestoreService;

  // final LocalDataService localDataService;

  static const mm = '💦💦💦💦 RepositoryService 💦';

  RepositoryService(
    this.dioUtil,
    this.prefs,
    this.paymentService,
    this.firestoreService,
  );

  final SponsorPrefs prefs;
  final RapydPaymentService paymentService;

  Future<Organization?> getSgelaOrganization() async {
    String prefix = ChatbotEnvironment.getSkunkUrl();
    String url = '${prefix}organizations/getSgelaOrganization';
    var result = await dioUtil.sendGetRequest(path:url, params:  {});
    pp('$mm ... response from call: ${result.data}');
    Organization org = Organization.fromJson(result.data);
    return org;
  }

  Future<Organization?> registerOrganization(Organization organization) async {
    String prefix = ChatbotEnvironment.getSkunkUrl();
    String url = '${prefix}organizations/addOrganization';
    pp('$mm ...registerOrganization: calling: $url');

    var result = await dioUtil.sendPostRequest(path:url, body:organization.toJson());
    pp('$mm ... response from call: $result');
    Organization org = Organization.fromJson(result.data);
    prefs.saveOrganization(org);
    prefs.saveCountry(org.country!);

    return org;
  }

  Future<Branding> uploadBrandingWithNoFiles(Branding branding) async {
    pp('$mm ... uploadBrandingWithNoFiles ....');

    try {
      var prefix = ChatbotEnvironment.getSkunkUrl();
      var url = '${prefix}organizations/uploadBrandingWithNoFiles';
      pp('$mm ... uploadBrandingWithNoFiles calling: $url');

      var res = await dioUtil.sendPostRequest(path:url, body:branding.toJson());
      pp('$mm res; $res');

      var uploadedBranding = Branding.fromJson(res.data);
      if (uploadedBranding.logoUrl != null) {
        SponsorPrefs prefs = GetIt.instance<SponsorPrefs>();
        prefs.saveLogoUrl(uploadedBranding.logoUrl!);
      }
      var mList =
          await firestoreService.getBranding(branding.organizationId!, true);

      pp('$mm branding added, now we have ${mList.length}');
      return uploadedBranding;
      // }
    } catch (error, s) {
      pp('$mm Error uploading branding: $error');
      pp(s);
      throw Exception(
          'Sorry, Branding upload failed. Please try again in a minute');
    }
  }

  Future<Branding> uploadBranding(
      {required int organizationId,
      required String organizationName,
      required String tagLine,
      required String orgUrl,
      required int splashTimeInSeconds,
      required int colorIndex,
      required File? logoFile,
      required File? splashFile}) async {
    pp('$mm Logo File: ${((await logoFile?.length())!/1024/1024).toStringAsFixed(2)} MB bytes');
    pp('$mm Splash File: ${((await splashFile?.length())!/1024/1024).toStringAsFixed(2)} MB bytes');
    try {
      var prefix = ChatbotEnvironment.getSkunkUrl();
      var url = '';
      if (logoFile != null) {
        url = '${prefix}organizations/uploadBrandingWithLogo';
      } else {
        url = '${prefix}organizations/uploadBrandingWithoutLogo';
      }
      pp('$mm ... uploadBranding calling: $url');
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields['organizationId'] = '$organizationId';
      request.fields['organizationName'] = organizationName;
      request.fields['tagLine'] = tagLine;
      request.fields['orgUrl'] = orgUrl;
      request.fields['colorIndex'] = "$colorIndex";
      request.fields['splashTimeInSeconds'] = '$splashTimeInSeconds';

      if (logoFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('logoFile', logoFile.path));
      }

      if (splashFile != null) {
        request.files.add(
            await http.MultipartFile.fromPath('splashFile', splashFile.path));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var uploadedBranding = Branding.fromJson(jsonDecode(responseData));
        if (uploadedBranding.logoUrl != null) {
          SponsorPrefs prefs = GetIt.instance<SponsorPrefs>();
          prefs.saveLogoUrl(uploadedBranding.logoUrl!);
        }
        var mList = await firestoreService.getBranding(organizationId, true);
        return uploadedBranding;
      } else {
        var responseData = await response.stream.bytesToString();
        pp('$mm ERROR: $responseData');
      }
    } catch (error) {
      pp('Error uploading branding: $error');
    }
    throw Exception(
        'Sorry, Branding upload failed. Please try again in a minute');
  }

  final StreamController<int> _streamController = StreamController.broadcast();

  Stream<int> get pageStream => _streamController.stream;
}
