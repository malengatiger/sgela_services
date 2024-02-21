import 'package:json_annotation/json_annotation.dart';
import 'package:sgela_services/data/pricing.dart';


part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  int? countryId, id;
  int? organizationId;
  int? userId;
  String? date, organizationName;
  String? payfastToken;
  Pricing? pricing;
  String? subscriptionType;
  bool? activeFlag;

  Subscription(this.id, this.countryId, this.organizationId, this.userId, this.payfastToken,
      this.date, this.pricing, this.subscriptionType, this.activeFlag, this.organizationName);

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$SubscriptionToJson(this);

    if (pricing != null) {
      data['pricing'] = pricing!.toJson();
    }

    return data;
  }
}

const freeSubscription  = 'FREE' ;
const monthlySubscription  = 'MONTHLY' ;
const annualSubscription  = 'ANNUAL' ;