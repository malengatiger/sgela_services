// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgUser _$OrgUserFromJson(Map<String, dynamic> json) => OrgUser(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      cellphone: json['cellphone'] as String?,
      date: json['date'] as String?,
      id: json['id'] as int?,
      organizationId: json['organizationId'] as int?,
      organizationName: json['organizationName'] as String?,
      cityName: json['cityName'] as String?,
      activeFlag: json['activeFlag'] as bool?,
      password: json['password'] as String?,
      firebaseUserId: json['firebaseUserId'] as String?,
    );

Map<String, dynamic> _$OrgUserToJson(OrgUser instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'cellphone': instance.cellphone,
      'date': instance.date,
      'id': instance.id,
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
      'cityName': instance.cityName,
      'firebaseUserId': instance.firebaseUserId,
      'activeFlag': instance.activeFlag,
      'password': instance.password,
    };
