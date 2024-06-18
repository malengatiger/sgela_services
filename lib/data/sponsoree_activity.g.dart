// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsoree_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsoreeActivity _$SponsoreeActivityFromJson(Map<String, dynamic> json) =>
    SponsoreeActivity(
      organizationId: (json['organizationId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      date: json['date'] as String?,
      organizationName: json['organizationName'] as String?,
      totalTokens: (json['totalTokens'] as num?)?.toInt(),
      elapsedTimeInSeconds: (json['elapsedTimeInSeconds'] as num?)?.toInt(),
      aiModel: json['aiModel'] as String?,
      sponsoreeId: (json['sponsoreeId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      sponsoreeName: json['sponsoreeName'] as String?,
      sponsoreeEmail: json['sponsoreeEmail'] as String?,
      sponsoreeCellphone: json['sponsoreeCellphone'] as String?,
      examLinkId: (json['examLinkId'] as num?)?.toInt(),
      examTitle: json['examTitle'] as String?,
      subjectId: (json['subjectId'] as num?)?.toInt(),
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$SponsoreeActivityToJson(SponsoreeActivity instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'id': instance.id,
      'date': instance.date,
      'organizationName': instance.organizationName,
      'totalTokens': instance.totalTokens,
      'elapsedTimeInSeconds': instance.elapsedTimeInSeconds,
      'aiModel': instance.aiModel,
      'sponsoreeId': instance.sponsoreeId,
      'userId': instance.userId,
      'sponsoreeName': instance.sponsoreeName,
      'sponsoreeEmail': instance.sponsoreeEmail,
      'sponsoreeCellphone': instance.sponsoreeCellphone,
      'examLinkId': instance.examLinkId,
      'examTitle': instance.examTitle,
      'subject': instance.subject,
      'subjectId': instance.subjectId,
    };
