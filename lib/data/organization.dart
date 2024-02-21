import 'package:json_annotation/json_annotation.dart';

import 'city.dart';
import 'country.dart';
import 'org_user.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
  String? name, email, cellphone;
  int? id;
  Country? country;
  City? city;

  OrgUser? adminUser;
  String? logoUrl, splashUrl, tagLine, websiteUrl, date;
  int? brandingElapsedTimeInSeconds;
  bool? activeFlag;

  Organization({required this.name,
    required this.email,
    required this.cellphone,
    required this.id,
    required this.date,
    required this.country,
    this.city,
    required this.adminUser,
    required this.logoUrl,
    required this.splashUrl,
    this.activeFlag,
    required this.tagLine});

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
