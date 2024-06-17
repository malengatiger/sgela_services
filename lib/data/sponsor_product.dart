
import 'package:json_annotation/json_annotation.dart';

part 'sponsor_product.g.dart';
@JsonSerializable()

class SponsorProduct {
  double? amountPerSponsoree;
  String? title;
  int? periodInMonths;
  String? currency;
  String? countryName;
  String? date;
  int? id;
  bool? activeFlag;
  int? studentsSponsored;


  SponsorProduct(
      this.amountPerSponsoree,
      this.title,
      this.periodInMonths,
      this.currency,
      this.countryName,
      this.date,
      this.id,
      this.activeFlag,
      this.studentsSponsored);

  factory SponsorProduct.fromJson(Map<String, dynamic> json) =>
      _$SponsorProductFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorProductToJson(this);
}

@JsonSerializable()

class OrganizationSponsorPaymentType {
  int? organizationId;
  String? organizationName;
  SponsorProduct? sponsorPaymentType;
  String? date;


  OrganizationSponsorPaymentType(this.organizationId, this.organizationName,
      this.sponsorPaymentType, this.date);

  factory OrganizationSponsorPaymentType.fromJson(Map<String, dynamic> json) =>
      _$OrganizationSponsorPaymentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationSponsorPaymentTypeToJson(this);
}