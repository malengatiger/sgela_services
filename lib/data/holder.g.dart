// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    PaymentMethod(
      json['type'] as String?,
      json['name'] as String?,
      json['category'] as String?,
      json['image'] as String?,
      json['country'] as String?,
      json['payment_flow_type'] as String?,
      (json['currencies'] as List<dynamic>).map((e) => e as String).toList(),
      json['status'] as int?,
      json['is_cancelable'] as bool?,
      (json['payment_options'] as List<dynamic>)
          .map((e) => PaymentOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_expirable'] as bool?,
      json['is_online'] as bool?,
      json['is_refundable'] as bool?,
      json['minimum_expiration_seconds'] as int?,
      json['maximum_expiration_seconds'] as int?,
      json['virtual_payment_method_type'],
      json['is_virtual'] as bool?,
      json['multiple_overage_allowed'] as bool?,
      (json['amount_range_per_currency'] as List<dynamic>)
          .map(
              (e) => AmountRangePerCurrency.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_tokenizable'] as bool?,
      json['supported_digital_wallet_providers'] as List<dynamic>,
      json['is_restricted'] as bool?,
      json['supports_subscription'] as bool?,
    );

Map<String, dynamic> _$PaymentMethodToJson(PaymentMethod instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'category': instance.category,
      'image': instance.image,
      'country': instance.country,
      'payment_flow_type': instance.paymentFlowType,
      'currencies': instance.currencies,
      'status': instance.status,
      'is_cancelable': instance.isCancellable,
      'payment_options': instance.paymentOptions,
      'is_expirable': instance.is_expirable,
      'is_online': instance.isOnline,
      'is_refundable': instance.is_refundable,
      'minimum_expiration_seconds': instance.minimum_expiration_seconds,
      'maximum_expiration_seconds': instance.maximum_expiration_seconds,
      'virtual_payment_method_type': instance.virtual_payment_method_type,
      'is_virtual': instance.is_virtual,
      'multiple_overage_allowed': instance.multiple_overage_allowed,
      'amount_range_per_currency': instance.amount_range_per_currency,
      'is_tokenizable': instance.is_tokenizable,
      'supported_digital_wallet_providers':
          instance.supported_digital_wallet_providers,
      'is_restricted': instance.is_restricted,
      'supports_subscription': instance.supports_subscription,
    };

CustomerRequest _$CustomerRequestFromJson(Map<String, dynamic> json) =>
    CustomerRequest(
      json['name'] as String?,
      json['business_vat_id'] as String?,
      json['email'] as String?,
      json['invoice_prefix'] as String?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(
              json['payment_method'] as Map<String, dynamic>),
      json['phone_number'] as String?,
    );

Map<String, dynamic> _$CustomerRequestToJson(CustomerRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'business_vat_id': instance.business_vat_id,
      'email': instance.email,
      'invoice_prefix': instance.invoice_prefix,
      'metadata': instance.metadata,
      'payment_method': instance.payment_method,
      'phone_number': instance.phone_number,
    };

AmountRangePerCurrency _$AmountRangePerCurrencyFromJson(
        Map<String, dynamic> json) =>
    AmountRangePerCurrency(
      json['currency'] as String?,
      (json['maximum_amount'] as num?)?.toDouble(),
      json['minimum_amount'] as int?,
    );

Map<String, dynamic> _$AmountRangePerCurrencyToJson(
        AmountRangePerCurrency instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'maximum_amount': instance.maximum_amount,
      'minimum_amount': instance.minimum_amount,
    };

PaymentOption _$PaymentOptionFromJson(Map<String, dynamic> json) =>
    PaymentOption(
      json['name'] as String?,
      json['type'] as String?,
      json['regex'] as String?,
      json['description'] as String?,
      json['is_required'],
      json['is_updatable'],
      (json['required_fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['conditions'] as List<dynamic>?)
          ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentOptionToJson(PaymentOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'regex': instance.regex,
      'description': instance.description,
      'is_required': instance.is_required,
      'is_updatable': instance.is_updatable,
      'required_fields': instance.required_fields,
      'conditions': instance.conditions,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      json['error_code'] as String?,
      json['status'] as String?,
      json['message'] as String?,
      json['response_code'] as String?,
      json['operation_id'] as String?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'error_code': instance.error_code,
      'status': instance.status,
      'message': instance.message,
      'response_code': instance.response_code,
      'operation_id': instance.operation_id,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      json['name'] as String?,
      json['type'] as String?,
      json['regex'] as String?,
      json['is_required'] as bool?,
      json['instructions'] as String?,
      json['description'] as String?,
      json['is_updatable'] as bool?,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'regex': instance.regex,
      'is_required': instance.is_required,
      'instructions': instance.instructions,
      'description': instance.description,
      'is_updatable': instance.is_updatable,
    };

PaymentMethodOption _$PaymentMethodOptionFromJson(Map<String, dynamic> json) =>
    PaymentMethodOption(
      json['name'] as String?,
      json['type'] as String?,
      json['regex'] as String?,
      json['description'] as String?,
      json['is_required'] as bool?,
      json['is_updatable'] as bool?,
    );

Map<String, dynamic> _$PaymentMethodOptionToJson(
        PaymentMethodOption instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'regex': instance.regex,
      'description': instance.description,
      'is_required': instance.is_required,
      'is_updatable': instance.is_updatable,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
      json['operator'] as String?,
      json['description'] as String?,
      json['element_name'] as String?,
      json['threshold_value'] as String?,
    );

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'operator': instance.operator,
      'description': instance.description,
      'element_name': instance.element_name,
      'threshold_value': instance.threshold_value,
    };

RequiredFields _$RequiredFieldsFromJson(Map<String, dynamic> json) =>
    RequiredFields(
      json['type'] as String?,
      (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['payment_method_options'] as List<dynamic>?)
          ?.map((e) => PaymentMethodOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['payment_options'] as List<dynamic>?)
          ?.map((e) => PaymentOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['minimum_expiration_seconds'] as int?,
      json['maximum_expiration_seconds'] as int?,
    );

Map<String, dynamic> _$RequiredFieldsToJson(RequiredFields instance) =>
    <String, dynamic>{
      'type': instance.type,
      'fields': instance.fields,
      'payment_method_options': instance.payment_method_options,
      'payment_options': instance.payment_options,
      'minimum_expiration_seconds': instance.minimum_expiration_seconds,
      'maximum_expiration_seconds': instance.maximum_expiration_seconds,
    };

RequiredFieldsResponse _$RequiredFieldsResponseFromJson(
        Map<String, dynamic> json) =>
    RequiredFieldsResponse(
      (json['data'] as List<dynamic>)
          .map((e) => RequiredFields.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequiredFieldsResponseToJson(
        RequiredFieldsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
    };

PaymentByCardRequest _$PaymentByCardRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentByCardRequest(
      (json['amount'] as num?)?.toDouble(),
      json['currency'] as String?,
      json['customer'] as String?,
      json['paymentMethod'] == null
          ? null
          : PaymentMethod.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      json['capture'] as bool?,
      json['3DS_required'] as bool?,
    );

Map<String, dynamic> _$PaymentByCardRequestToJson(
        PaymentByCardRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'customer': instance.customer,
      'paymentMethod': instance.paymentMethod,
      'capture': instance.capture,
      '3DS_required': instance.threeDRequired,
    };

PaymentMethodResponse _$PaymentMethodResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      (json['data'] as List<dynamic>)
          .map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentMethodResponseToJson(
        PaymentMethodResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      json['merchant_defined'] as bool?,
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'merchant_defined': instance.merchant_defined,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['id'] as String?,
      json['active'] as bool?,
      (json['attributes'] as List<dynamic>).map((e) => e as String).toList(),
      json['created_at'] as int?,
      json['description'] as String?,
      json['images'] as List<dynamic>,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['name'] as String?,
      json['package_dimensions'] == null
          ? null
          : PackageDimensions.fromJson(
              json['package_dimensions'] as Map<String, dynamic>),
      json['shippable'] as bool?,
      json['skus'] as List<dynamic>,
      json['statement_descriptor'] as String?,
      json['type'] as String?,
      json['unit_label'] as String?,
      json['updated_at'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'attributes': instance.attributes,
      'created_at': instance.created_at,
      'description': instance.description,
      'images': instance.images,
      'metadata': instance.metadata,
      'name': instance.name,
      'package_dimensions': instance.package_dimensions,
      'shippable': instance.shippable,
      'skus': instance.skus,
      'statement_descriptor': instance.statement_descriptor,
      'type': instance.type,
      'unit_label': instance.unit_label,
      'updated_at': instance.updated_at,
    };

PackageDimensions _$PackageDimensionsFromJson(Map<String, dynamic> json) =>
    PackageDimensions(
      json['height'] as int?,
      json['length'] as int?,
      json['weight'] as int?,
      json['width'] as int?,
    );

Map<String, dynamic> _$PackageDimensionsToJson(PackageDimensions instance) =>
    <String, dynamic>{
      'height': instance.height,
      'length': instance.length,
      'weight': instance.weight,
      'width': instance.width,
    };

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : Product.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

PlanRequest _$PlanRequestFromJson(Map<String, dynamic> json) => PlanRequest(
      json['currency'] as String?,
      json['interval'] as String?,
      json['product'] as String?,
      json['aggregate_usage'] as String?,
      json['billing_scheme'] as String?,
      json['nickname'] as String?,
      (json['tiers'] as List<dynamic>)
          .map((e) => Tier.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tiers_mode'] as String?,
      json['transform_usage'] == null
          ? null
          : TransformUsage.fromJson(
              json['transform_usage'] as Map<String, dynamic>),
      json['trial_period_days'] as int?,
      json['usage_type'] as String?,
    );

Map<String, dynamic> _$PlanRequestToJson(PlanRequest instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'interval': instance.interval,
      'product': instance.product,
      'aggregate_usage': instance.aggregate_usage,
      'billing_scheme': instance.billing_scheme,
      'nickname': instance.nickname,
      'tiers': instance.tiers,
      'tiers_mode': instance.tiers_mode,
      'transform_usage': instance.transform_usage,
      'trial_period_days': instance.trial_period_days,
      'usage_type': instance.usage_type,
    };

PlanResponse _$PlanResponseFromJson(Map<String, dynamic> json) => PlanResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : Plan.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanResponseToJson(PlanResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

PlanListResponse _$PlanListResponseFromJson(Map<String, dynamic> json) =>
    PlanListResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      (json['data'] as List<dynamic>)
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanListResponseToJson(PlanListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      json['id'] as String?,
      json['aggregate_usage'] as String?,
      json['amount'] as int?,
      json['billing_scheme'] as String?,
      json['created_at'] as int?,
      json['currency'] as String?,
      json['interval'] as String?,
      json['interval_count'] as int?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      json['nickname'] as String?,
      (json['tiers'] as List<dynamic>)
          .map((e) => Tier.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tiers_mode'] as String?,
      json['transform_usage'] == null
          ? null
          : TransformUsage.fromJson(
              json['transform_usage'] as Map<String, dynamic>),
      json['trial_period_days'] as int?,
      json['usage_type'] as String?,
      json['active'] as bool?,
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'aggregate_usage': instance.aggregate_usage,
      'amount': instance.amount,
      'billing_scheme': instance.billing_scheme,
      'created_at': instance.created_at,
      'currency': instance.currency,
      'interval': instance.interval,
      'interval_count': instance.interval_count,
      'metadata': instance.metadata,
      'product': instance.product,
      'nickname': instance.nickname,
      'tiers': instance.tiers,
      'tiers_mode': instance.tiers_mode,
      'transform_usage': instance.transform_usage,
      'trial_period_days': instance.trial_period_days,
      'usage_type': instance.usage_type,
      'active': instance.active,
    };

Tier _$TierFromJson(Map<String, dynamic> json) => Tier(
      json['amount'] as int?,
      json['up_to'] as String?,
      json['flat_amount'] as int?,
    );

Map<String, dynamic> _$TierToJson(Tier instance) => <String, dynamic>{
      'amount': instance.amount,
      'up_to': instance.up_to,
      'flat_amount': instance.flat_amount,
    };

TransformUsage _$TransformUsageFromJson(Map<String, dynamic> json) =>
    TransformUsage(
      json['divide_by'] as int?,
      json['round'] as String?,
    );

Map<String, dynamic> _$TransformUsageToJson(TransformUsage instance) =>
    <String, dynamic>{
      'divide_by': instance.divide_by,
      'round': instance.round,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : Customer.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CustomerListResponse _$CustomerListResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerListResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      (json['data'] as List<dynamic>)
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerListResponseToJson(
        CustomerListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      json['id'] as String?,
      json['delinquent'] as bool?,
      json['discount'],
      json['name'] as String?,
      json['default_payment_method'] as String?,
      json['description'] as String?,
      json['email'] as String?,
      json['phone_number'] as String?,
      json['invoice_prefix'] as String?,
      json['addresses'] as List<dynamic>,
      json['payment_methods'] == null
          ? null
          : PaymentMethods.fromJson(
              json['payment_methods'] as Map<String, dynamic>),
      json['subscriptions'],
      json['created_at'] as int?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['business_vat_id'] as String?,
      json['ewallet'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'delinquent': instance.delinquent,
      'discount': instance.discount,
      'name': instance.name,
      'default_payment_method': instance.default_payment_method,
      'description': instance.description,
      'email': instance.email,
      'phone_number': instance.phone_number,
      'invoice_prefix': instance.invoice_prefix,
      'addresses': instance.addresses,
      'payment_methods': instance.payment_methods,
      'subscriptions': instance.subscriptions,
      'created_at': instance.created_at,
      'metadata': instance.metadata,
      'business_vat_id': instance.business_vat_id,
      'ewallet': instance.ewallet,
    };

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      (json['data'] as List<dynamic>)
          .map((e) => PaymentMethodStub.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['has_more'] as bool?,
      json['total_count'] as int?,
      json['url'] as String?,
    );

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'data': instance.data,
      'has_more': instance.has_more,
      'total_count': instance.total_count,
      'url': instance.url,
    };

PaymentMethodStub _$PaymentMethodStubFromJson(Map<String, dynamic> json) =>
    PaymentMethodStub(
      json['id'] as String?,
      json['type'] as String?,
      json['category'] as String?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['image'] as String?,
      json['webhook_url'] as String?,
      json['supporting_documentation'] as String?,
      json['next_action'] as String?,
      json['bic_swift'] as String?,
      json['account_last4'] as String?,
      json['language'] as String?,
      json['redirect_url'] as String?,
    );

Map<String, dynamic> _$PaymentMethodStubToJson(PaymentMethodStub instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'category': instance.category,
      'metadata': instance.metadata,
      'image': instance.image,
      'webhook_url': instance.webhook_url,
      'supporting_documentation': instance.supporting_documentation,
      'next_action': instance.next_action,
      'bic_swift': instance.bic_swift,
      'account_last4': instance.account_last4,
      'language': instance.language,
      'redirect_url': instance.redirect_url,
    };

CheckoutRequest _$CheckoutRequestFromJson(Map<String, dynamic> json) =>
    CheckoutRequest(
      json['amount'] as int?,
      json['complete_payment_url'] as String?,
      json['country'] as String?,
      json['currency'] as String?,
      json['customer'] as String?,
      json['error_payment_url'] as String?,
      json['merchant_reference_id'] as String?,
      json['cardholder_preferred_currency'] as bool?,
      json['language'] as String?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      (json['payment_method_types_include'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['expiration'] as int?,
      json['cancel_checkout_url'] as String?,
      json['complete_checkout_url'] as String?,
      json['payment_method_types_exclude'] as List<dynamic>,
    );

Map<String, dynamic> _$CheckoutRequestToJson(CheckoutRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'complete_payment_url': instance.complete_payment_url,
      'country': instance.country,
      'currency': instance.currency,
      'customer': instance.customer,
      'error_payment_url': instance.error_payment_url,
      'merchant_reference_id': instance.merchant_reference_id,
      'cardholder_preferred_currency': instance.cardholder_preferred_currency,
      'language': instance.language,
      'metadata': instance.metadata,
      'payment_method_types_include': instance.payment_method_types_include,
      'expiration': instance.expiration,
      'cancel_checkout_url': instance.cancel_checkout_url,
      'complete_checkout_url': instance.complete_checkout_url,
      'payment_method_types_exclude': instance.payment_method_types_exclude,
    };

CheckoutResponse _$CheckoutResponseFromJson(Map<String, dynamic> json) =>
    CheckoutResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : Checkout.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutResponseToJson(CheckoutResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

Checkout _$CheckoutFromJson(Map<String, dynamic> json) => Checkout(
      json['id'] as String?,
      json['status'] as String?,
      json['language'] as String?,
      json['org_id'] as String?,
      json['merchant_color'],
      json['merchant_logo'],
      json['merchant_website'] as String?,
      json['merchant_customer_support'] == null
          ? null
          : MerchantCustomerSupport.fromJson(
              json['merchant_customer_support'] as Map<String, dynamic>),
      json['merchant_alias'] as String?,
      json['merchant_terms'],
      json['merchant_privacy_policy'],
      json['page_expiration'] as int?,
      json['redirect_url'] as String?,
      json['merchant_main_button'] as String?,
      json['cancel_checkout_url'] as String?,
      json['complete_checkout_url'] as String?,
      json['country'] as String?,
      json['currency'] as String?,
      json['amount'] as int?,
      json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      json['payment_method_type'],
      json['payment_method_type_categories'],
      (json['payment_method_types_include'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['payment_method_types_exclude'] as List<dynamic>,
      json['account_funding_transaction'],
      json['customer'] as String?,
      json['custom_elements'] == null
          ? null
          : CustomElements.fromJson(
              json['custom_elements'] as Map<String, dynamic>),
      json['timestamp'] as int?,
      json['payment_expiration'],
      json['cart_items'] as List<dynamic>,
      json['escrow'],
      json['escrow_release_days'],
    );

Map<String, dynamic> _$CheckoutToJson(Checkout instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'language': instance.language,
      'org_id': instance.org_id,
      'merchant_color': instance.merchant_color,
      'merchant_logo': instance.merchant_logo,
      'merchant_website': instance.merchant_website,
      'merchant_customer_support': instance.merchant_customer_support,
      'merchant_alias': instance.merchant_alias,
      'merchant_terms': instance.merchant_terms,
      'merchant_privacy_policy': instance.merchant_privacy_policy,
      'page_expiration': instance.page_expiration,
      'redirect_url': instance.redirect_url,
      'merchant_main_button': instance.merchant_main_button,
      'cancel_checkout_url': instance.cancel_checkout_url,
      'complete_checkout_url': instance.complete_checkout_url,
      'country': instance.country,
      'currency': instance.currency,
      'amount': instance.amount,
      'payment': instance.payment,
      'payment_method_type': instance.payment_method_type,
      'payment_method_type_categories': instance.payment_method_type_categories,
      'payment_method_types_include': instance.payment_method_types_include,
      'payment_method_types_exclude': instance.payment_method_types_exclude,
      'account_funding_transaction': instance.account_funding_transaction,
      'customer': instance.customer,
      'custom_elements': instance.custom_elements,
      'timestamp': instance.timestamp,
      'payment_expiration': instance.payment_expiration,
      'cart_items': instance.cart_items,
      'escrow': instance.escrow,
      'escrow_release_days': instance.escrow_release_days,
    };

CustomElements _$CustomElementsFromJson(Map<String, dynamic> json) =>
    CustomElements(
      json['save_card_default'] as bool?,
      json['display_description'] as bool?,
      json['payment_fees_display'] as bool?,
      json['merchant_currency_only'] as bool?,
      json['billing_address_collect'] as bool?,
      json['dynamic_currency_conversion'] as bool?,
    );

Map<String, dynamic> _$CustomElementsToJson(CustomElements instance) =>
    <String, dynamic>{
      'save_card_default': instance.save_card_default,
      'display_description': instance.display_description,
      'payment_fees_display': instance.payment_fees_display,
      'merchant_currency_only': instance.merchant_currency_only,
      'billing_address_collect': instance.billing_address_collect,
      'dynamic_currency_conversion': instance.dynamic_currency_conversion,
    };

PaymentByBankTransferRequest _$PaymentByBankTransferRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentByBankTransferRequest(
      (json['amount'] as num?)?.toDouble(),
      json['currency'] as String?,
      json['customer'] as String?,
      json['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(
              json['payment_method'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentByBankTransferRequestToJson(
        PaymentByBankTransferRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'customer': instance.customer,
      'payment_method': instance.payment_method,
    };

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) =>
    PaymentResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : Payment.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

PaymentListResponse _$PaymentListResponseFromJson(Map<String, dynamic> json) =>
    PaymentListResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      (json['data'] as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentListResponseToJson(
        PaymentListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

PaymentByWalletRequest _$PaymentByWalletRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentByWalletRequest(
      (json['amount'] as num?)?.toDouble(),
      json['currency'] as String?,
      json['customer'] as String?,
      json['payment_method'] == null
          ? null
          : PaymentMethod.fromJson(
              json['payment_method'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentByWalletRequestToJson(
        PaymentByWalletRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'customer': instance.customer,
      'payment_method': instance.payment_method,
    };

Fields _$FieldsFromJson(Map<String, dynamic> json) => Fields(
      json['number'] as String?,
      json['expiration_month'] as String?,
      json['expiration_year'] as String?,
      json['name'] as String?,
      json['cvv'] as String?,
    );

Map<String, dynamic> _$FieldsToJson(Fields instance) => <String, dynamic>{
      'number': instance.number,
      'expiration_month': instance.expiration_month,
      'expiration_year': instance.expiration_year,
      'name': instance.name,
      'cvv': instance.cvv,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['id'] as String?,
      json['amount'] as int?,
      json['original_amount'] as int?,
      json['is_partial'] as bool?,
      json['currency_code'] as String?,
      json['country_code'] as String?,
      json['status'] as String?,
      json['description'] as String?,
      json['merchant_reference_id'] as String?,
      json['customer_token'] as String?,
      json['payment_method'] as String?,
      json['payment_method_data'] == null
          ? null
          : PaymentMethodData.fromJson(
              json['payment_method_data'] as Map<String, dynamic>),
      json['auth_code'],
      json['expiration'] as int?,
      json['captured'] as bool?,
      json['refunded'] as bool?,
      json['refunded_amount'] as int?,
      json['receipt_email'] as String?,
      json['redirect_url'] as String?,
      json['complete_payment_url'] as String?,
      json['error_payment_url'] as String?,
      json['receipt_number'] as String?,
      json['flow_type'] as String?,
      json['address'],
      json['statement_descriptor'] as String?,
      json['transaction_id'] as String?,
      json['created_at'] as int?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['failure_code'] as String?,
      json['failure_message'] as String?,
      json['paid'] as bool?,
      json['paid_at'] as int?,
      json['dispute'],
      json['refunds'],
      json['order'],
      json['outcome'],
      json['ewallet_id'] as String?,
      (json['ewallets'] as List<dynamic>)
          .map((e) => EWallet.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['payment_method_type'] as String?,
      json['payment_method_type_category'] as String?,
      (json['fx_rate'] as num?)?.toDouble(),
      json['merchant_requested_currency'],
      json['merchant_requested_amount'],
      json['fixed_side'] as String?,
      json['payment_fees'],
      json['invoice'] as String?,
      json['escrow'],
      json['group_payment'] as String?,
      json['cancel_reason'],
      json['initiation_type'] as String?,
      json['mid'] as String?,
      json['next_action'] as String?,
      json['error_code'] as String?,
      json['save_payment_method'] as bool?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'original_amount': instance.original_amount,
      'is_partial': instance.is_partial,
      'currency_code': instance.currency_code,
      'country_code': instance.country_code,
      'status': instance.status,
      'description': instance.description,
      'merchant_reference_id': instance.merchant_reference_id,
      'customer_token': instance.customer_token,
      'payment_method': instance.payment_method,
      'payment_method_data': instance.payment_method_data,
      'auth_code': instance.auth_code,
      'expiration': instance.expiration,
      'captured': instance.captured,
      'refunded': instance.refunded,
      'refunded_amount': instance.refunded_amount,
      'receipt_email': instance.receipt_email,
      'redirect_url': instance.redirect_url,
      'complete_payment_url': instance.complete_payment_url,
      'error_payment_url': instance.error_payment_url,
      'receipt_number': instance.receipt_number,
      'flow_type': instance.flow_type,
      'address': instance.address,
      'statement_descriptor': instance.statement_descriptor,
      'transaction_id': instance.transaction_id,
      'created_at': instance.created_at,
      'metadata': instance.metadata,
      'failure_code': instance.failure_code,
      'failure_message': instance.failure_message,
      'paid': instance.paid,
      'paid_at': instance.paid_at,
      'dispute': instance.dispute,
      'refunds': instance.refunds,
      'order': instance.order,
      'outcome': instance.outcome,
      'ewallet_id': instance.ewallet_id,
      'ewallets': instance.ewallets,
      'payment_method_type': instance.payment_method_type,
      'payment_method_type_category': instance.payment_method_type_category,
      'fx_rate': instance.fx_rate,
      'merchant_requested_currency': instance.merchant_requested_currency,
      'merchant_requested_amount': instance.merchant_requested_amount,
      'fixed_side': instance.fixed_side,
      'payment_fees': instance.payment_fees,
      'invoice': instance.invoice,
      'escrow': instance.escrow,
      'group_payment': instance.group_payment,
      'cancel_reason': instance.cancel_reason,
      'initiation_type': instance.initiation_type,
      'mid': instance.mid,
      'next_action': instance.next_action,
      'error_code': instance.error_code,
      'save_payment_method': instance.save_payment_method,
    };

PaymentMethodData _$PaymentMethodDataFromJson(Map<String, dynamic> json) =>
    PaymentMethodData(
      json['id'] as String?,
      json['type'] as String?,
      json['category'] as String?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['image'] as String?,
      json['webhook_url'] as String?,
      json['supporting_documentation'] as String?,
      json['next_action'] as String?,
      json['bic_swift'] as String?,
      json['account_last4'] as String?,
    );

Map<String, dynamic> _$PaymentMethodDataToJson(PaymentMethodData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'category': instance.category,
      'metadata': instance.metadata,
      'image': instance.image,
      'webhook_url': instance.webhook_url,
      'supporting_documentation': instance.supporting_documentation,
      'next_action': instance.next_action,
      'bic_swift': instance.bic_swift,
      'account_last4': instance.account_last4,
    };

Instruction _$InstructionFromJson(Map<String, dynamic> json) => Instruction(
      json['name'] as String?,
      (json['steps'] as List<dynamic>)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'steps': instance.steps,
    };

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      json['step1'] as String?,
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'step1': instance.step1,
    };

EWallet _$EWalletFromJson(Map<String, dynamic> json) => EWallet(
      json['ewallet_id'] as String?,
      json['amount'] as int?,
      (json['percent'] as num?)?.toDouble(),
      json['refunded_amount'] as int?,
    );

Map<String, dynamic> _$EWalletToJson(EWallet instance) => <String, dynamic>{
      'ewallet_id': instance.ewallet_id,
      'amount': instance.amount,
      'percent': instance.percent,
      'refunded_amount': instance.refunded_amount,
    };

PaymentLinkResponse _$PaymentLinkResponseFromJson(Map<String, dynamic> json) =>
    PaymentLinkResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : PaymentLink.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentLinkResponseToJson(
        PaymentLinkResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

LinkCheckout _$LinkCheckoutFromJson(Map<String, dynamic> json) => LinkCheckout(
      json['error_payment_url'] as String?,
      json['complete_payment_url'] as String?,
    );

Map<String, dynamic> _$LinkCheckoutToJson(LinkCheckout instance) =>
    <String, dynamic>{
      'error_payment_url': instance.error_payment_url,
      'complete_payment_url': instance.complete_payment_url,
    };

PaymentLinkRequest _$PaymentLinkRequestFromJson(Map<String, dynamic> json) =>
    PaymentLinkRequest(
      json['country'] as String?,
      json['currency'] as String?,
      json['amount'] as int?,
      json['merchantReferenceId'] as String?,
      json['language'] as String?,
      json['checkout'] == null
          ? null
          : LinkCheckout.fromJson(json['checkout'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentLinkRequestToJson(PaymentLinkRequest instance) =>
    <String, dynamic>{
      'country': instance.country,
      'currency': instance.currency,
      'amount': instance.amount,
      'merchantReferenceId': instance.merchantReferenceId,
      'language': instance.language,
      'checkout': instance.checkout,
    };

PaymentLink _$PaymentLinkFromJson(Map<String, dynamic> json) => PaymentLink(
      json['id'] as String?,
      json['amount'] as int?,
      json['currency'] as String?,
      json['country'] as String?,
      json['amount_is_editable'] as bool?,
      json['merchant_reference_id'] as String?,
      json['redirect_url'] as String?,
      json['template'] == null
          ? null
          : Template.fromJson(json['template'] as Map<String, dynamic>),
      json['customer'] as String?,
      json['status'] as String?,
      json['language'] as String?,
      json['merchant_color'] as String?,
      json['merchant_logo'] as String?,
      json['merchant_website'] as String?,
      json['merchant_customer_support'] == null
          ? null
          : MerchantCustomerSupport.fromJson(
              json['merchant_customer_support'] as Map<String, dynamic>),
      json['merchant_alias'] as String?,
      json['merchant_terms'] as String?,
      json['merchant_privacy_policy'] as String?,
      json['page_expiration'] as int?,
    );

Map<String, dynamic> _$PaymentLinkToJson(PaymentLink instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'currency': instance.currency,
      'country': instance.country,
      'amount_is_editable': instance.amount_is_editable,
      'merchant_reference_id': instance.merchant_reference_id,
      'redirect_url': instance.redirect_url,
      'template': instance.template,
      'customer': instance.customer,
      'status': instance.status,
      'language': instance.language,
      'merchant_color': instance.merchant_color,
      'merchant_logo': instance.merchant_logo,
      'merchant_website': instance.merchant_website,
      'merchant_customer_support': instance.merchant_customer_support,
      'merchant_alias': instance.merchant_alias,
      'merchant_terms': instance.merchant_terms,
      'merchant_privacy_policy': instance.merchant_privacy_policy,
      'page_expiration': instance.page_expiration,
    };

Template _$TemplateFromJson(Map<String, dynamic> json) => Template(
      json['error_payment_url'] as String?,
      json['complete_payment_url'] as String?,
    );

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'error_payment_url': instance.error_payment_url,
      'complete_payment_url': instance.complete_payment_url,
    };

CustomerPaymentMethod _$CustomerPaymentMethodFromJson(
        Map<String, dynamic> json) =>
    CustomerPaymentMethod(
      json['id'] as String?,
      json['type'] as String?,
      json['category'] as String?,
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      json['image'] as String?,
      json['webhook_url'] as String?,
      json['supporting_documentation'] as String?,
      json['next_action'] as String?,
      json['name'] as String?,
      json['last4'] as String?,
      json['acs_check'] as String?,
      json['cvv_check'] as String?,
      json['bin_details'] == null
          ? null
          : BinDetails.fromJson(json['bin_details'] as Map<String, dynamic>),
      json['expiration_year'] as String?,
      json['expiration_month'] as String?,
      json['fingerprint_token'] as String?,
      json['redirect_url'] as String?,
      json['complete_payment_url'] as String?,
      json['error_payment_url'] as String?,
    );

Map<String, dynamic> _$CustomerPaymentMethodToJson(
        CustomerPaymentMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'category': instance.category,
      'metadata': instance.metadata,
      'image': instance.image,
      'webhook_url': instance.webhook_url,
      'supporting_documentation': instance.supporting_documentation,
      'next_action': instance.next_action,
      'name': instance.name,
      'last4': instance.last4,
      'acs_check': instance.acs_check,
      'cvv_check': instance.cvv_check,
      'bin_details': instance.bin_details,
      'expiration_year': instance.expiration_year,
      'expiration_month': instance.expiration_month,
      'fingerprint_token': instance.fingerprint_token,
      'redirect_url': instance.redirect_url,
      'complete_payment_url': instance.complete_payment_url,
      'error_payment_url': instance.error_payment_url,
    };

BinDetails _$BinDetailsFromJson(Map<String, dynamic> json) => BinDetails(
      json['type'] as String?,
      json['brand'] as String?,
      json['level'],
      json['issuer'] as String?,
      json['country'] as String?,
      json['bin_number'] as String?,
    );

Map<String, dynamic> _$BinDetailsToJson(BinDetails instance) =>
    <String, dynamic>{
      'type': instance.type,
      'brand': instance.brand,
      'level': instance.level,
      'issuer': instance.issuer,
      'country': instance.country,
      'bin_number': instance.bin_number,
    };

MerchantCustomerSupport _$MerchantCustomerSupportFromJson(
        Map<String, dynamic> json) =>
    MerchantCustomerSupport(
      json['url'] as String?,
      json['email'] as String?,
      json['phone_number'] as String?,
    );

Map<String, dynamic> _$MerchantCustomerSupportToJson(
        MerchantCustomerSupport instance) =>
    <String, dynamic>{
      'url': instance.url,
      'email': instance.email,
      'phone_number': instance.phone_number,
    };

AddCustomerPaymentMethodRequest _$AddCustomerPaymentMethodRequestFromJson(
        Map<String, dynamic> json) =>
    AddCustomerPaymentMethodRequest(
      json['type'] as String?,
      json['complete_payment_url'] as String?,
      json['error_payment_url'] as String?,
      (json['fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddCustomerPaymentMethodRequestToJson(
        AddCustomerPaymentMethodRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'complete_payment_url': instance.complete_payment_url,
      'error_payment_url': instance.error_payment_url,
      'fields': instance.fields,
      'metadata': instance.metadata,
    };

CustomerPaymentMethodResponse _$CustomerPaymentMethodResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerPaymentMethodResponse(
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['data'] == null
          ? null
          : CustomerPaymentMethod.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerPaymentMethodResponseToJson(
        CustomerPaymentMethodResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
