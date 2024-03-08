import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sgela_services/sgela_util/functions.dart';


class InAppPurchaseService {
  void _onPurchaseDetailsReceived(
      List<PurchaseDetails> purchaseDetailsList) {
    pp('$mm ❤️❤️❤️❤️❤️... purchaseStream delivered _onPurchaseDetailsReceived: '
        '${purchaseDetailsList.length} came in ...❤️');
    for (var pds in purchaseDetailsList) {
      pp('$mm ... 🔵🔵status: ${pds.status.name} 🔵🔵error.code: ${pds.error?.code} '
          '🔵🔵pendingCompletePurchase: ${pds.pendingCompletePurchase} 🔵🔵productID: ${pds.productID}');
    }
  }

  static const mm = '🛂🛂🛂🛂🛂🛂 InAppPurchaseService  🚼🚼';

  Future<void> registerGoogleAndAppleInAppPurchase() async {
    pp('$mm .... registerGoogleAndAppleInAppPurchase: 🔵🔵🔵🔵 ... initialize stores ....');

    try {
      // 1. listen to events from the store
      InAppPurchase.instance.purchaseStream.listen((purchaseDetailsList) {
        _onPurchaseDetailsReceived(purchaseDetailsList);
      });
      if (Platform.isIOS) {
        getAppleProducts();
      } else {
        getGoogleProducts();
      }
    } catch (e, s) {
      pp('$mm fucking ERROR: 👿👿👿$e 👿👿👿 $s');
      //todo - CRITICAL - don't want this to be fucked up!
    }
  }

  List<ProductDetails> _oneTimeProductDetails = [];
  List<ProductDetails> _subscriptionDetails = [];

  List<ProductDetails> get oneTimeProductDetails => _oneTimeProductDetails;

  List<ProductDetails> get subscriptionDetails => _subscriptionDetails;

  Future purchaseProduct(ProductDetails productDetails, bool isSubscription) async {

    try {
      PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      bool ok = false;
      if (isSubscription) {
         ok = await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
      }  else {
         ok = await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
      }
      return ok;
      //todo - store PurchaseParam on db
    } catch (e,s) {
      pp('$mm $e - $s');
      throw Exception('$e');
    }
  }

  Future<void> getGoogleProducts() async {
    if (!Platform.isAndroid) {
      return;
    }
    pp('\n\n$mm 🔵🔵🔵🔵🔵🔵🔵_getGoogleProducts products from store .....🔵🔵🔵🔵');

    bool available = await InAppPurchase.instance.isAvailable();
    pp('$mm ... InAppPurchase.instance: ${InAppPurchase.instance.isAvailable()}');
    if (!available) {
      return;
    }

    Set<String> ids = {"product_id5", 'product_id9', 'one_time_gold'};
    Set<String> ids2 = {
      'product_id3',
      'subscription_monthly_1',
    };
    await _fetchProducts(ids, ids2, 'Google Play Store');
  }

  Future<void> getAppleProducts() async {
    if (!Platform.isIOS) {
      return;
    }
    pp('\n\n$mm 🔵🔵🔵🔵🔵🔵🔵_getAppleProducts: products from store .....🔵🔵🔵🔵');

    bool available = await InAppPurchase.instance.isAvailable();
    pp('$mm ... InAppPurchase.instance: ${InAppPurchase.instance.isAvailable()}');
    if (!available) {
      return;
    }

    Set<String> ids = {
      'SgelaAIParent',
      'SgelaAIOneTimeGold',
      'SgelaAISilverOneTime',
    };
    Set<String> ids2 = {
      "SgelaAIAnnualSub",
      "SgelaAIMonthlySub",
    };
    await _fetchProducts(ids,ids2, 'Apple App Store');
  }

  Future<void> _fetchProducts(Set<String> ids, Set<String> ids2, String store) async {
    var response = await InAppPurchase.instance.queryProductDetails(ids);
    if (response.notFoundIDs.isNotEmpty) {
      pp("Warning: Some ids where not found: ${response.notFoundIDs}");
    }

    pp('\n\n\n$mm ... queryProductDetails response, Apple productDetails: ${response.productDetails.length} \n\n');
    _oneTimeProductDetails = response.productDetails;
    _oneTimeProductDetails.sort((a, b) => a.title.compareTo(b.title));
    pp('\n\n\n$mm 🥦🥦🥦$store ONE TIME PURCHASE PRODUCTS 🥦🥦 ${_oneTimeProductDetails.length} products 🥦');
    for (var value in _oneTimeProductDetails) {

      pp('$mm ... product, 🔵id: ${value.id} 🔵title: ${value.title} \n🔵description: ${value.description} '
          '🔵currencySymbol: ${value.currencySymbol} 🔵currencyCode: ${value.currencyCode} 💚price: ${value.price} 💚rawPrice: ${value.rawPrice}\n\n');
    }

    var response2 = await InAppPurchase.instance.queryProductDetails(ids2);
    _subscriptionDetails = response2.productDetails;
    _subscriptionDetails.sort((a, b) => a.title.compareTo(b.title));
    pp('\n\n\n$mm 🥦🥦🥦$store SUBSCRIPTION PRODUCTS 🥦🥦 ${_subscriptionDetails.length} products 🥦');
    for (var value in _subscriptionDetails) {
      pp('$mm ... product, 🔵id: ${value.id} 🔵title: ${value.title} \n🔵description: ${value.description} '
          '🔵currencySymbol: ${value.currencySymbol} 🔵currencyCode: ${value.currencyCode} 💚price: ${value.price} 💚rawPrice: ${value.rawPrice}\n\n');
    }
  }


}
