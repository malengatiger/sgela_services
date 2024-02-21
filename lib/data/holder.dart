



import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'holder.g.dart';

@JsonSerializable()
class PaymentMethod {
  String? type;
  String? name;
  String? category;
  String? image;
  String? country;
  @JsonKey(name: 'payment_flow_type')
  String? paymentFlowType;
  List<String> currencies = [];
  int?  status;
  @JsonKey(name: 'is_cancelable')
  bool?    isCancellable;
  @JsonKey(name: 'payment_options')
  List<PaymentOption> paymentOptions = [];
  @JsonKey(name: 'is_expirable')
  bool?    is_expirable;
  @JsonKey(name: 'is_online')
  bool?    isOnline;
  bool?    is_refundable;
  int?  minimum_expiration_seconds;
  int?  maximum_expiration_seconds;
  dynamic virtual_payment_method_type;
  bool?    is_virtual;
  bool?    multiple_overage_allowed;
  List<AmountRangePerCurrency> amount_range_per_currency = [];
  bool?    is_tokenizable;
  List<dynamic> supported_digital_wallet_providers = [];
  bool?    is_restricted;
  bool?    supports_subscription;

  PaymentMethod(
      this.type,
      this.name,
      this.category,
      this.image,
      this.country,
      this.paymentFlowType,
      this.currencies,
      this.status,
      this.isCancellable,
      this.paymentOptions,
      this.is_expirable,
      this.isOnline,
      this.is_refundable,
      this.minimum_expiration_seconds,
      this.maximum_expiration_seconds,
      this.virtual_payment_method_type,
      this.is_virtual,
      this.multiple_overage_allowed,
      this.amount_range_per_currency,
      this.is_tokenizable,
      this.supported_digital_wallet_providers,
      this.is_restricted,
      this.supports_subscription);
  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
@JsonSerializable()

class CustomerRequest {
  String? name;
  String? business_vat_id;
  String? email;
  String? invoice_prefix;
  Metadata? metadata;
  PaymentMethod? payment_method;
  String? phone_number;

  CustomerRequest(
      this.name,
      this.business_vat_id,
      this.email,
      this.invoice_prefix,
      this.metadata,
      this.payment_method,
      this.phone_number);

  factory CustomerRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRequestToJson(this);
}
@JsonSerializable()

class AmountRangePerCurrency {
  String? currency;
  double? maximum_amount;
  int?  minimum_amount;

  AmountRangePerCurrency(
      this.currency, this.maximum_amount, this.minimum_amount);
  factory AmountRangePerCurrency.fromJson(Map<String, dynamic> json) =>
      _$AmountRangePerCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$AmountRangePerCurrencyToJson(this);
}
@JsonSerializable()

class PaymentOption {
  String? name;
  String? type;
  String? regex;
  String? description;
  dynamic    is_required;
  dynamic    is_updatable;
  List<Field>? required_fields = [];
  List<Condition>? conditions = [];

  PaymentOption(
      this.name,
      this.type,
      this.regex,
      this.description,
      this.is_required,
      this.is_updatable,
      this.required_fields,
      this.conditions);
  factory PaymentOption.fromJson(Map<String, dynamic> json) =>
      _$PaymentOptionFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentOptionToJson(this);
}
@JsonSerializable()

class Status {
  String? error_code;
  String? status;
  String? message;
  String? response_code;
  String? operation_id;

  Status(this.error_code, this.status, this.message, this.response_code,
      this.operation_id);
  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}
@JsonSerializable()

class Field {
  String? name;
  String? type;
  String? regex;
  bool?    is_required;
  String? instructions;
  String? description;
  bool?    is_updatable;

  Field(this.name, this.type, this.regex, this.is_required, this.instructions,
      this.description, this.is_updatable);
  factory Field.fromJson(Map<String, dynamic> json) =>
      _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
@JsonSerializable()

class PaymentMethodOption {
  String? name;
  String? type;
  String? regex;
  String? description;
  bool?    is_required;
  bool?    is_updatable;

  PaymentMethodOption(this.name, this.type, this.regex, this.description,
      this.is_required, this.is_updatable);
  factory PaymentMethodOption.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodOptionFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodOptionToJson(this);
}
@JsonSerializable()

class Condition {
  String? operator;
  String? description;
  String? element_name;
  String? threshold_value;

  Condition(
      this.operator, this.description,
      this.element_name, this.threshold_value);

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}
@JsonSerializable()

class RequiredFields {
  String? type;
  List<Field>? fields = [];
  List<PaymentMethodOption>? payment_method_options = [];
  List<PaymentOption>? payment_options = [];
  int?  minimum_expiration_seconds;
  int?  maximum_expiration_seconds;

  RequiredFields(
      this.type,
      this.fields,
      this.payment_method_options,
      this.payment_options,
      this.minimum_expiration_seconds,
      this.maximum_expiration_seconds);
  factory RequiredFields.fromJson(Map<String, dynamic> json) =>
      _$RequiredFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredFieldsToJson(this);
}
@JsonSerializable()

class RequiredFieldsResponse {
  List<RequiredFields> data = [];
  Status? status;

  RequiredFieldsResponse(this.data, this.status);
  factory RequiredFieldsResponse.fromJson(Map<String, dynamic> json) =>
      _$RequiredFieldsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredFieldsResponseToJson(this);
}
/*
export class PaymentByCardRequest {
  amount: number;
  currency: string;
  customer: string;
  payment_method: PaymentMethod;
  capture: boolean;
  "3DS_required": boolean;
}
export class PaymentByWalletRequest {
  amount: number;
  currency: string;
  customer: string;
  payment_method: PaymentMethod;

}
 */
@JsonSerializable()
class PaymentByCardRequest {
  double? amount;
  String? currency;
  String? customer;
  PaymentMethod? paymentMethod;
  bool? capture;
  @JsonKey(name: '3DS_required')
  bool? threeDRequired;

  PaymentByCardRequest(this.amount, this.currency, this.customer,
      this.paymentMethod, this.capture, this.threeDRequired);
  factory PaymentByCardRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentByCardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentByCardRequestToJson(this);
}
@JsonSerializable()

class PaymentMethodResponse {
  Status? status;
  List<PaymentMethod> data = [];

  PaymentMethodResponse(this.status, this.data);
  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);
}
@JsonSerializable()

class Metadata {
  bool?    merchant_defined;
  Metadata(this.merchant_defined);
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
@JsonSerializable()

class Product {
  String? id;
  bool?    active;
  List<String> attributes = [];
  int?  created_at;
  String? description;
  List<dynamic> images = [];
  Metadata? metadata ;
  String? name;
  PackageDimensions? package_dimensions;
  bool?    shippable;
  List<dynamic> skus = [];
  String? statement_descriptor;
  String? type;
  String? unit_label;
  int?  updated_at;

  Product(
      this.id,
      this.active,
      this.attributes,
      this.created_at,
      this.description,
      this.images,
      this.metadata,
      this.name,
      this.package_dimensions,
      this.shippable,
      this.skus,
      this.statement_descriptor,
      this.type,
      this.unit_label,
      this.updated_at);
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
@JsonSerializable()

class PackageDimensions {
  int?  height;
  int?  length;
  int?  weight;
  int?  width;

  PackageDimensions(this.height, this.length, this.weight, this.width);
  factory PackageDimensions.fromJson(Map<String, dynamic> json) =>
      _$PackageDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$PackageDimensionsToJson(this);
}
@JsonSerializable()

class ProductResponse {
  Status? status;
  Product? data;

  ProductResponse(this.status, this.data);
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

// class ProductsResponse {
//   Status? status;
//   List<Product> data = [];
//
//   ProductsResponse(this.status, this.data);
//   factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
//       _$ProductsResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
// }
@JsonSerializable()
class PlanRequest {
  String? currency;
  String? interval;
  String? product;
  String? aggregate_usage;
  String? billing_scheme;
  String? nickname;
  List<Tier> tiers;
  String? tiers_mode;
  TransformUsage? transform_usage;
  int?  trial_period_days;
  String? usage_type;

  PlanRequest(
      this.currency,
      this.interval,
      this.product,
      this.aggregate_usage,
      this.billing_scheme,
      this.nickname,
      this.tiers,
      this.tiers_mode,
      this.transform_usage,
      this.trial_period_days,
      this.usage_type);
  factory PlanRequest.fromJson(Map<String, dynamic> json) =>
      _$PlanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlanRequestToJson(this);
}
@JsonSerializable()

class PlanResponse {
  Status? status;
  Plan? data;

  PlanResponse(this.status, this.data);
  factory PlanResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlanResponseToJson(this);
}
@JsonSerializable()

class PlanListResponse {
  Status? status;
  List<Plan> data = [];

  PlanListResponse(this.status, this.data);
  factory PlanListResponse.fromJson(Map<String, dynamic> json) =>
      _$PlanListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlanListResponseToJson(this);
}
@JsonSerializable()

class Plan {
  String? id;
  String? aggregate_usage;
  int?  amount;
  String? billing_scheme;
  int?  created_at;
  String? currency;
  String? interval;
  int?  interval_count;
  Metadata? metadata ;
  Product? product;
  String? nickname;
  List<Tier> tiers = [];
  String? tiers_mode;
  TransformUsage? transform_usage;
  int?  trial_period_days;
  String? usage_type;
  bool?    active;

  Plan(
      this.id,
      this.aggregate_usage,
      this.amount,
      this.billing_scheme,
      this.created_at,
      this.currency,
      this.interval,
      this.interval_count,
      this.metadata,
      this.product,
      this.nickname,
      this.tiers,
      this.tiers_mode,
      this.transform_usage,
      this.trial_period_days,
      this.usage_type,
      this.active);
  factory Plan.fromJson(Map<String, dynamic> json) =>
      _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
@JsonSerializable()

class Tier {
  int?  amount;
  String? up_to;
  int?  flat_amount;

  Tier(this.amount, this.up_to, this.flat_amount);
  factory Tier.fromJson(Map<String, dynamic> json) =>
      _$TierFromJson(json);

  Map<String, dynamic> toJson() => _$TierToJson(this);
}
@JsonSerializable()

class TransformUsage {
  int?  divide_by;
  String? round;

  TransformUsage(this.divide_by, this.round);
  factory TransformUsage.fromJson(Map<String, dynamic> json) =>
      _$TransformUsageFromJson(json);

  Map<String, dynamic> toJson() => _$TransformUsageToJson(this);
}
@JsonSerializable()

class CustomerResponse {
  Status? status;
  Customer? data;

  CustomerResponse(this.status, this.data);
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}
@JsonSerializable()

class CustomerListResponse {
  Status? status;
  List<Customer> data = [];

  CustomerListResponse(this.status, this.data);
  factory CustomerListResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerListResponseToJson(this);
}
@JsonSerializable()

class Customer {
  String? id;
  bool?    delinquent;
  dynamic discount;
  String? name;
  String? default_payment_method;
  String? description;
  String? email;
  String? phone_number;
  String? invoice_prefix;
  List<dynamic> addresses = [];
  PaymentMethods? payment_methods;
  dynamic subscriptions;
  int?  created_at;
  Metadata? metadata ;
  String? business_vat_id;
  String? ewallet;

  Customer(
      this.id,
      this.delinquent,
      this.discount,
      this.name,
      this.default_payment_method,
      this.description,
      this.email,
      this.phone_number,
      this.invoice_prefix,
      this.addresses,
      this.payment_methods,
      this.subscriptions,
      this.created_at,
      this.metadata,
      this.business_vat_id,
      this.ewallet);
  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
@JsonSerializable()

class PaymentMethods {
  List<PaymentMethodStub> data = [];
  bool?    has_more;
  int?  total_count;
  String? url;

  PaymentMethods(this.data, this.has_more, this.total_count, this.url);
  factory PaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodsToJson(this);
}
@JsonSerializable()

class PaymentMethodStub {
  String? id;
  String? type;
  String? category;
  Metadata? metadata ;
  String? image;
  String? webhook_url;
  String? supporting_documentation;
  String? next_action;
  String? bic_swift;
  String? account_last4;
  String? language;
  String? redirect_url;

  PaymentMethodStub(
      this.id,
      this.type,
      this.category,
      this.metadata,
      this.image,
      this.webhook_url,
      this.supporting_documentation,
      this.next_action,
      this.bic_swift,
      this.account_last4,
      this.language,
      this.redirect_url);
  factory PaymentMethodStub.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodStubFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodStubToJson(this);
}
@JsonSerializable()

class CheckoutRequest {
  int?  amount;
  String? complete_payment_url;
  String? country;
  String? currency;
  String? customer;
  String? error_payment_url;
  String? merchant_reference_id;
  bool?    cardholder_preferred_currency;
  String? language;
  Metadata? metadata ;
  List<String> payment_method_types_include = [];
  int?  expiration;
  String? cancel_checkout_url;
  String? complete_checkout_url;
  List<dynamic> payment_method_types_exclude = [];

  CheckoutRequest(
      this.amount,
      this.complete_payment_url,
      this.country,
      this.currency,
      this.customer,
      this.error_payment_url,
      this.merchant_reference_id,
      this.cardholder_preferred_currency,
      this.language,
      this.metadata,
      this.payment_method_types_include,
      this.expiration,
      this.cancel_checkout_url,
      this.complete_checkout_url,
      this.payment_method_types_exclude);

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}
@JsonSerializable()

class CheckoutResponse {
  Status? status;
  Checkout? data;

  CheckoutResponse(this.status, this.data);
  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
@JsonSerializable()

class Checkout {
  String? id;
  String? status;
  String? language;
  String? org_id;
  dynamic merchant_color;
  dynamic merchant_logo;
  String? merchant_website;
  MerchantCustomerSupport? merchant_customer_support;
  String? merchant_alias;
  dynamic merchant_terms;
  dynamic merchant_privacy_policy;
  int?  page_expiration;
  String? redirect_url;
  String? merchant_main_button;
  String? cancel_checkout_url;
  String? complete_checkout_url;
  String? country;
  String? currency;
  int?  amount;
  Payment? payment;
  dynamic payment_method_type;
  dynamic payment_method_type_categories;
  List<String> payment_method_types_include = [];
  List<dynamic> payment_method_types_exclude = [];
  dynamic account_funding_transaction;
  String? customer;
  CustomElements? custom_elements;
  int?  timestamp;
  dynamic payment_expiration;
  List<dynamic> cart_items = [];
  dynamic escrow;
  dynamic escrow_release_days;

  Checkout(
      this.id,
      this.status,
      this.language,
      this.org_id,
      this.merchant_color,
      this.merchant_logo,
      this.merchant_website,
      this.merchant_customer_support,
      this.merchant_alias,
      this.merchant_terms,
      this.merchant_privacy_policy,
      this.page_expiration,
      this.redirect_url,
      this.merchant_main_button,
      this.cancel_checkout_url,
      this.complete_checkout_url,
      this.country,
      this.currency,
      this.amount,
      this.payment,
      this.payment_method_type,
      this.payment_method_type_categories,
      this.payment_method_types_include,
      this.payment_method_types_exclude,
      this.account_funding_transaction,
      this.customer,
      this.custom_elements,
      this.timestamp,
      this.payment_expiration,
      this.cart_items,
      this.escrow,
      this.escrow_release_days);
  factory Checkout.fromJson(Map<String, dynamic> json) =>
      _$CheckoutFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutToJson(this);
}

class VisualCodes {}

class TextualCodes {}

class Instructions {}


@JsonSerializable()

class CustomElements {
  bool?    save_card_default;
  bool?    display_description;
  bool?    payment_fees_display;
  bool?    merchant_currency_only;
  bool?    billing_address_collect;
  bool?    dynamic_currency_conversion;

  CustomElements(
      this.save_card_default,
      this.display_description,
      this.payment_fees_display,
      this.merchant_currency_only,
      this.billing_address_collect,
      this.dynamic_currency_conversion);
  factory CustomElements.fromJson(Map<String, dynamic> json) =>
      _$CustomElementsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomElementsToJson(this);
}
@JsonSerializable()

class PaymentByBankTransferRequest {
  double?  amount;
  String? currency;
  String? customer;
  PaymentMethod? payment_method;

  PaymentByBankTransferRequest(
      this.amount, this.currency, this.customer, this.payment_method);
  factory PaymentByBankTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentByBankTransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentByBankTransferRequestToJson(this);
}
@JsonSerializable()

class PaymentResponse {
  Status? status;
  Payment? data;

  PaymentResponse(this.status, this.data);
  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);
}
@JsonSerializable()

class PaymentListResponse {
  Status? status;
  List<Payment> data = [];

  PaymentListResponse(this.status, this.data);
  factory PaymentListResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentListResponseToJson(this);
}

// class PaymentByCardRequest {
//   int?  amount;
//   String? currency;
//   String? customer;
//   PaymentMethod? payment_method;
//   bool?    capture;
//   bool?    _3DS_required;
//
//   PaymentByCardRequest(this.amount, this.currency, this.customer,
//       this.payment_method, this.capture, this._3DS_required);
//   factory PaymentByCardRequest.fromJson(Map<String, dynamic> json) =>
//       _$PaymentByCardRequestFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PaymentByCardRequestToJson(this);
// }
@JsonSerializable()

class PaymentByWalletRequest {
  double?  amount;
  String? currency;
  String? customer;
  PaymentMethod? payment_method;

  PaymentByWalletRequest(
      this.amount, this.currency, this.customer, this.payment_method);

  factory PaymentByWalletRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentByWalletRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentByWalletRequestToJson(this);
}
@JsonSerializable()

class Fields {
  String? number;
  String? expiration_month;
  String? expiration_year;
  String? name;
  String? cvv;

  Fields(this.number, this.expiration_month, this.expiration_year, this.name,
      this.cvv);
  factory Fields.fromJson(Map<String, dynamic> json) =>
      _$FieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FieldsToJson(this);
}
@JsonSerializable()

class Payment {
  String? id;
  int?  amount;
  int?  original_amount;
  bool?    is_partial;
  String? currency_code;
  String? country_code;
  String? status;
  String? description;
  String? merchant_reference_id;
  String? customer_token;
  String? payment_method;
  PaymentMethodData? payment_method_data;
  dynamic auth_code;
  int?  expiration;
  bool?    captured;
  bool?    refunded;
  int?  refunded_amount;
  String? receipt_email;
  String? redirect_url;
  String? complete_payment_url;
  String? error_payment_url;
  String? receipt_number;
  String? flow_type;
  dynamic address;
  String? statement_descriptor;
  String? transaction_id;
  int?  created_at;
  Metadata? metadata ;
  String? failure_code;
  String? failure_message;
  bool?    paid;
  int?  paid_at;
  dynamic dispute;
  dynamic refunds;
  dynamic order;
  dynamic outcome;
  // VisualCodes? visual_codes;
  // TextualCodes? textual_codes;
  // List<Instruction> instructions = [];
  String? ewallet_id;
  List<EWallet> ewallets = [];
  // PaymentMethodOptions? payment_method_options;
  String? payment_method_type;
  String? payment_method_type_category;
  double? fx_rate;
  dynamic merchant_requested_currency;
  dynamic merchant_requested_amount;
  String? fixed_side;
  dynamic payment_fees;
  String? invoice;
  dynamic escrow;
  String? group_payment;
  dynamic cancel_reason;
  String? initiation_type;
  String? mid;
  String? next_action;
  String? error_code;
  // RemitterInformation? remitter_information;
  bool?    save_payment_method;

  Payment(
      this.id,
      this.amount,
      this.original_amount,
      this.is_partial,
      this.currency_code,
      this.country_code,
      this.status,
      this.description,
      this.merchant_reference_id,
      this.customer_token,
      this.payment_method,
      this.payment_method_data,
      this.auth_code,
      this.expiration,
      this.captured,
      this.refunded,
      this.refunded_amount,
      this.receipt_email,
      this.redirect_url,
      this.complete_payment_url,
      this.error_payment_url,
      this.receipt_number,
      this.flow_type,
      this.address,
      this.statement_descriptor,
      this.transaction_id,
      this.created_at,
      this.metadata,
      this.failure_code,
      this.failure_message,
      this.paid,
      this.paid_at,
      this.dispute,
      this.refunds,
      this.order,
      this.outcome,
      this.ewallet_id,
      this.ewallets,
      this.payment_method_type,
      this.payment_method_type_category,
      this.fx_rate,
      this.merchant_requested_currency,
      this.merchant_requested_amount,
      this.fixed_side,
      this.payment_fees,
      this.invoice,
      this.escrow,
      this.group_payment,
      this.cancel_reason,
      this.initiation_type,
      this.mid,
      this.next_action,
      this.error_code,
      // this.remitter_information,
      this.save_payment_method);

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
@JsonSerializable()

class PaymentMethodData {
  String? id;
  String? type;
  String? category;
  Metadata? metadata ;
  String? image;
  String? webhook_url;
  String? supporting_documentation;
  String? next_action;
  String? bic_swift;
  String? account_last4;

  PaymentMethodData(
      this.id,
      this.type,
      this.category,
      this.metadata,
      this.image,
      this.webhook_url,
      this.supporting_documentation,
      this.next_action,
      this.bic_swift,
      this.account_last4);

  factory PaymentMethodData.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodDataToJson(this);
}
@JsonSerializable()

class Instruction {
  String? name;
  List<Step> steps = [];

  Instruction(this.name, this.steps);
  factory Instruction.fromJson(Map<String, dynamic> json) =>
      _$InstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionToJson(this);
}
@JsonSerializable()

class Step {
  String? step1;

  Step(this.step1);
  factory Step.fromJson(Map<String, dynamic> json) =>
      _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
@JsonSerializable()

class EWallet {
  String? ewallet_id;
  int?  amount;
  double? percent;
  int?  refunded_amount;
  factory EWallet.fromJson(Map<String, dynamic> json) =>
      _$EWalletFromJson(json);

  Map<String, dynamic> toJson() => _$EWalletToJson(this);

  EWallet(this.ewallet_id, this.amount, this.percent, this.refunded_amount);

}

class RemitterInformation {}
@JsonSerializable()

class PaymentLinkResponse {
  Status? status;
  PaymentLink? data;

  PaymentLinkResponse(this.status, this.data);
  factory PaymentLinkResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentLinkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentLinkResponseToJson(this);
}
@JsonSerializable()

class LinkCheckout {
  String? error_payment_url;
  String? complete_payment_url;

  LinkCheckout(this.error_payment_url, this.complete_payment_url);
  factory LinkCheckout.fromJson(Map<String, dynamic> json) =>
      _$LinkCheckoutFromJson(json);

  Map<String, dynamic> toJson() => _$LinkCheckoutToJson(this);
}
@JsonSerializable()

class PaymentLinkRequest {
  String? country;
  String? currency;
  int?  amount;
  String? merchantReferenceId;
  String? language;
  LinkCheckout? checkout;

  PaymentLinkRequest(this.country, this.currency, this.amount,
      this.merchantReferenceId, this.language, this.checkout);

  factory PaymentLinkRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentLinkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentLinkRequestToJson(this);
}
@JsonSerializable()

class PaymentLink {
  String? id;
  int?  amount;
  String? currency;
  String? country;
  bool?    amount_is_editable;
  String? merchant_reference_id;
  String? redirect_url;
  Template? template;
  String? customer;
  String? status;
  String? language;
  String? merchant_color;
  String? merchant_logo;
  String? merchant_website;
  MerchantCustomerSupport? merchant_customer_support;
  String? merchant_alias;
  String? merchant_terms;
  String? merchant_privacy_policy;
  int?  page_expiration;

  PaymentLink(
      this.id,
      this.amount,
      this.currency,
      this.country,
      this.amount_is_editable,
      this.merchant_reference_id,
      this.redirect_url,
      this.template,
      this.customer,
      this.status,
      this.language,
      this.merchant_color,
      this.merchant_logo,
      this.merchant_website,
      this.merchant_customer_support,
      this.merchant_alias,
      this.merchant_terms,
      this.merchant_privacy_policy,
      this.page_expiration);

  factory PaymentLink.fromJson(Map<String, dynamic> json) =>
      _$PaymentLinkFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentLinkToJson(this);
}
@JsonSerializable()

class Template {
  String? error_payment_url;
  String? complete_payment_url;

  Template(this.error_payment_url, this.complete_payment_url);
  factory Template.fromJson(Map<String, dynamic> json) =>
      _$TemplateFromJson(json);

  Map<String, dynamic> toJson() => _$TemplateToJson(this);
}
/*

export class CustomerPaymentMethodResponse {
  status: Status;
  data: CustomerPaymentMethod;
}
export class CustomerPaymentMethod {
  id: string;
  type: string;
  category: string;
  metadata: Metadata;
  image: string;
  webhook_url: string;
  supporting_documentation: string;
  next_action: string;
  name: string;
  last4: string;
  acs_check: string;
  cvv_check: string;
  bin_details: BinDetails;
  expiration_year: string;
  expiration_month: string;
  fingerprint_token: string;
  redirect_url: string;
  complete_payment_url: string;
  error_payment_url: string;
}
export class BinDetails {
  type: string;
  brand: string;
  level?: any;
  issuer: string;
  country: string;
  bin_number: string;
}
 */

@JsonSerializable()
class CustomerPaymentMethod {
  String? id;
  String? type;
  String? category;
  Metadata? metadata;
  String? image;
  String? webhook_url;
  String? supporting_documentation;
  String? next_action;
  String? name;
  String? last4;
  String? acs_check;
  String? cvv_check;
  BinDetails? bin_details;
  String? expiration_year;
  String? expiration_month;
  String? fingerprint_token;
  String? redirect_url;
  String? complete_payment_url;
  String? error_payment_url;

  CustomerPaymentMethod(
      this.id,
      this.type,
      this.category,
      this.metadata,
      this.image,
      this.webhook_url,
      this.supporting_documentation,
      this.next_action,
      this.name,
      this.last4,
      this.acs_check,
      this.cvv_check,
      this.bin_details,
      this.expiration_year,
      this.expiration_month,
      this.fingerprint_token,
      this.redirect_url,
      this.complete_payment_url,
      this.error_payment_url);
  factory CustomerPaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$CustomerPaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerPaymentMethodToJson(this);
}
@JsonSerializable()
class BinDetails {
  String? type;
  String? brand;
  dynamic level;
  String? issuer;
  String? country;
  String? bin_number;

  BinDetails(this.type, this.brand, this.level, this.issuer, this.country,
      this.bin_number);
  factory BinDetails.fromJson(Map<String, dynamic> json) =>
      _$BinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BinDetailsToJson(this);
}
@JsonSerializable()

class MerchantCustomerSupport {
  String? url;
  String? email;
  String? phone_number;

  MerchantCustomerSupport(this.url, this.email, this.phone_number);
  factory MerchantCustomerSupport.fromJson(Map<String, dynamic> json) =>
      _$MerchantCustomerSupportFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantCustomerSupportToJson(this);
}
@JsonSerializable()

class AddCustomerPaymentMethodRequest {
  String? type;
  String? complete_payment_url;
  String? error_payment_url;
  List<Field> fields = [];
  Metadata? metadata ;

  AddCustomerPaymentMethodRequest(this.type, this.complete_payment_url,
      this.error_payment_url, this.fields, this.metadata);

  factory AddCustomerPaymentMethodRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCustomerPaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCustomerPaymentMethodRequestToJson(this);
}
@JsonSerializable()

class CustomerPaymentMethodResponse {
  Status? status;
  CustomerPaymentMethod? data;

  CustomerPaymentMethodResponse(this.status, this.data);
  factory CustomerPaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerPaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerPaymentMethodResponseToJson(this);
}