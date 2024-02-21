import 'package:json_annotation/json_annotation.dart';

part 'org_user.g.dart';

@JsonSerializable()
class OrgUser {
  String? firstName, lastName, email, cellphone;
  String? date;
  int? id, organizationId;
  String? organizationName, cityName, firebaseUserId;
  bool? activeFlag;
  String? password;


  OrgUser({
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.cellphone,
      required this.date,
      required this.id,
      required this.organizationId,
      required this.organizationName,
      this.cityName,
    this.activeFlag, this.password,
      this.firebaseUserId});

  factory OrgUser.fromJson(Map<String, dynamic> json) =>
      _$OrgUserFromJson(json);

  Map<String, dynamic> toJson() => _$OrgUserToJson(this);
}
