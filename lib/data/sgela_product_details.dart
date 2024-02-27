import 'package:json_annotation/json_annotation.dart';

part 'sgela_product_details.g.dart';

@JsonSerializable()
class SgelaProductDetails {
  int? id, organizationId;

  String? productId;

  /// The title of the product.
  ///
  /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
  String? title;

  /// The description of the product.
  ///
  /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
  String? description, organizationName;

  /// The price of the product, formatted with currency symbol ("$0.99").
  ///
  /// For example, on iOS it is specified in App Store Connect; on Android, it is specified in Google Play Console.
  String? price;

  /// The unformatted price of the product, specified in the App Store Connect or Sku in Google Play console based on the platform.
  /// The currency unit for this value can be found in the [currencyCode] property.
  /// The value always describes full units of the currency. (e.g. 2.45 in the case of $2.45)
  double? rawPrice;

  /// The currency code for the price of the product.
  /// Based on the price specified in the App Store Connect or Sku in Google Play console based on the platform.
  String? currencyCode, date;

  /// The currency symbol for the locale, e.g. $ for US locale.
  ///
  /// When the currency symbol cannot be determined, the ISO 4217 currency code is returned.
  String? currencySymbol;
  bool? isOneTime;
  bool? isAppleStore;

  SgelaProductDetails(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.rawPrice,
      required this.currencyCode,
      required this.currencySymbol,
      required this.organizationId,
      required this.organizationName,
      required this.isOneTime,
      required this.isAppleStore,
      required this.productId,
      required this.date});

  factory SgelaProductDetails.fromJson(Map<String, dynamic> json) =>
      _$SgelaProductDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SgelaProductDetailsToJson(this);


}
