import 'package:dio/dio.dart';
import 'package:sgela_services/sgela_util/dio_util.dart';
import 'package:sgela_services/sgela_util/environment.dart';
import 'package:sgela_services/sgela_util/sponsor_prefs.dart';
import 'package:sgela_services/data/holder.dart';

import '../sgela_util/functions.dart';
class RapydPaymentService {
  final DioUtil dioUtil;
  static const mm = '🔵🔵🔵🔵🔵️RapydPaymentService: 🔵';

  RapydPaymentService(this.dioUtil, this.prefs);

  final SponsorPrefs prefs;

  var prefix = ChatbotEnvironment.getGeminiUrl();

  Future<RequiredFields> getPaymentMethodRequiredFields(
      String type) async {
    pp('$mm ... getPaymentMethodRequiredFields .... type: $type');

    var raw = await dioUtil.sendGetRequest(path:
        "${prefix}rapyd/getPaymentMethodRequiredFields?type=$type", queryParameters: {});
    RequiredFields reqFields = RequiredFields.fromJson(raw.data);
    int cnt = 1;

      try {
        pp('$mm ... RequiredFields for type: $type : 🌿🌿🌿 #$cnt 🍎🍎 ${reqFields.fields?.length}');
        if (reqFields.fields != null) {
          for (var field in reqFields.fields!) {
            pp('$mm  name: ${field.name} type: ${field.type} description: ${field.description}');
          }
        }
        if (reqFields.payment_options != null) {
          for (var option in reqFields.payment_options!) {
            pp('$mm  paymentOption:  🌀name: ${option.name} type: ${option.type} description: ${option.description}');
          }
        }
        if (reqFields.payment_method_options != null) {
          for (var option in reqFields.payment_method_options!) {
            pp('$mm  paymentMethodOption:  🌀name: ${option.name} type: ${option.type} description: ${option.description}');
          }
        }
        pp('\n\n');

      } catch (e,s) {
        pp('$mm ... getPaymentMethodRequiredFields ERROR ... e: $e');
        pp('$mm ... getPaymentMethodRequiredFields ERROR ... stackTrace: $s');

        pp(reqFields);
      }
      cnt++;

    return reqFields;
  }
  final List<PaymentMethod> methods = [];
  final List<RequiredFields> requiredFieldsList = [];
  Future<List<PaymentMethod>> getCountryPaymentMethods(
      String countryCode) async {
    pp('$mm ... getCountryPaymentMethods ....');
    var prefix = ChatbotEnvironment.getGeminiUrl();
    // var pms = prefs.getPaymentMethods();
    // if (pms.isNotEmpty) {
    //   pp('$mm ... getCountryPaymentMethods .... ${pms.length} found in cache');
    //   return pms;
    // }
    Response raw = await dioUtil.sendGetRequest(
        path: "${prefix}rapyd/getCountryPaymentMethods?countryCode=$countryCode",  queryParameters: {},);
    List mList = raw.data;
    int cnt = 1;
    for (var m in mList) {
      try {
        var pm = PaymentMethod.fromJson(m);
        pp('$mm ... payment method: 🍎🍎 #$cnt 🍎🍎 ${pm.name} \n');
        methods.add(pm);
        var rf = await getPaymentMethodRequiredFields(pm.type!);
        requiredFieldsList.add(rf);
      } catch (e,s) {
        pp('$mm ... getCountryPaymentMethods ERROR ... e: $e');
        pp('$mm ... getCountryPaymentMethods ERROR ... stackTrace: $s');
        pp(m);
      }
      cnt++;
    }
    pp('$mm ... getCountryPaymentMethods: save payment methods in prefs ... ${methods.length}');
    // prefs.savePaymentMethods(methods);
    return methods;
  }

  Future<Customer?> addCustomer(CustomerRequest customerReq) async {
    pp(' ... addCustomer ....');
    var url = '${prefix}rapyd/createCustomer';
    var resp = await dioUtil.sendPostRequest(path:url, body:customerReq.toJson());
    var cr = CustomerResponse.fromJson(resp.data);
    pp('$mm addCustomer response: ${cr.toJson()}');
    if (cr.data != null) {
      //prefs.saveCustomer(cr.data!);
    }
    return cr.data;
  }

  //  async addCustomerPaymentMethod(customer: string, type: string): Promise<any> {
  Future addCustomerPaymentMethod(String customer, String type) async {
    pp(' ... addCustomerPaymentMethod ...');
    var url = '${prefix}rapyd/addCustomerPaymentMethod';
    var resp = await dioUtil.sendGetRequest(path: url, queryParameters:  {
      "customer": customer,
      "type": type,
    });
    var cr = CustomerPaymentMethodResponse.fromJson(resp.data);
    pp('$mm addCustomerPaymentMethod response:  🥬🥬🥬🥬 ${cr.toJson()}');
    return cr.data;
  }

  Future<Checkout> createCheckOut(CheckoutRequest request) async {
    pp(' ... checkOut ....');
    var url = '${prefix}rapyd/createCheckout';
    var resp = await dioUtil.sendPostRequest(path:url, body:request.toJson());
    pp('$mm raw response from createCheckOut: $resp');
    var cr = CheckoutResponse.fromJson(resp.data);
    pp('$mm createCheckOut response, will need redirect: ${cr.toJson()}');
    return cr.data!;
  }
  Future<PaymentResponse> createPaymentByCard(PaymentByCardRequest request) async {
    pp(' ... createPaymentByCard ...');
    var url = '${prefix}rapyd/createPaymentByCard';
    var resp = await dioUtil.sendPostRequest(path:url, body: request.toJson());
    var cr = PaymentResponse.fromJson(resp.data);
    pp('$mm createPaymentByCard response, will need redirect: ${cr.toJson()}');
    return cr;
  }

  Future<PaymentResponse> createPaymentByBankTransfer(PaymentByBankTransferRequest request) async {
    pp(' ... payByBankTransfer ...');
    var url = '${prefix}rapyd/createPaymentByBankTransfer';
    var resp = await dioUtil.sendPostRequest(path:url, body:request.toJson());
    var cr = PaymentResponse.fromJson(resp.data);
    pp('$mm payByBankTransfer response, will need redirect: ${cr.toJson()}');
    return cr;
  }
  Future<PaymentResponse> createPaymentByWallet(PaymentByWalletRequest request) async {
    pp(' ... payByBankTransfer ...');
    var url = '${prefix}rapyd/createPaymentByWallet';
    var resp = await dioUtil.sendPostRequest(path:url, body: request.toJson());
    var cr = PaymentResponse.fromJson(resp.data);
    pp('$mm createPaymentByWallet response, will need redirect: ${cr.toJson()}');
    return cr;
  }

  Future payByWallet() async {
    pp(' ...');
  }

  Future getCustomerPayments() async {
    pp(' ...');
  }
}
