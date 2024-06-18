// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_index_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PineconeIndex _$PineconeIndexFromJson(Map<String, dynamic> json) =>
    PineconeIndex(
      json['name'] as String?,
      json['metric'] as String?,
      (json['dimension'] as num?)?.toInt(),
      json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      json['host'] as String?,
      json['spec'] == null
          ? null
          : Spec.fromJson(json['spec'] as Map<String, dynamic>),
      (json['examLinkId'] as num?)?.toInt(),
      (json['subjectId'] as num?)?.toInt(),
      json['examTitle'] as String?,
      json['subject'] as String?,
    );

Map<String, dynamic> _$PineconeIndexToJson(PineconeIndex instance) =>
    <String, dynamic>{
      'name': instance.name,
      'metric': instance.metric,
      'dimension': instance.dimension,
      'status': instance.status?.toJson(),
      'host': instance.host,
      'spec': instance.spec?.toJson(),
      'examLinkId': instance.examLinkId,
      'subjectId': instance.subjectId,
      'examTitle': instance.examTitle,
      'subject': instance.subject,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      ready: json['ready'] as bool?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'ready': instance.ready,
      'state': instance.state,
    };

Spec _$SpecFromJson(Map<String, dynamic> json) => Spec(
      serverless: json['serverless'] == null
          ? null
          : Serverless.fromJson(json['serverless'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpecToJson(Spec instance) => <String, dynamic>{
      'serverless': instance.serverless?.toJson(),
    };

Serverless _$ServerlessFromJson(Map<String, dynamic> json) => Serverless(
      region: json['region'] as String?,
      cloud: json['cloud'] as String?,
    );

Map<String, dynamic> _$ServerlessToJson(Serverless instance) =>
    <String, dynamic>{
      'region': instance.region,
      'cloud': instance.cloud,
    };
