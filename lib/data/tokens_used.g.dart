// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_used.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensUsed _$TokensUsedFromJson(Map<String, dynamic> json) => TokensUsed(
      json['organizationId'] as int?,
      json['sponsoreeId'] as int?,
      json['date'] as String?,
      json['sponsoreeName'] as String?,
      json['organizationName'] as String?,
      json['promptTokens'] as int?,
      json['completionTokens'] as int?,
      json['model'] as String?,
      json['totalTokens'] as int?,
    );

Map<String, dynamic> _$TokensUsedToJson(TokensUsed instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'sponsoreeId': instance.sponsoreeId,
      'date': instance.date,
      'sponsoreeName': instance.sponsoreeName,
      'organizationName': instance.organizationName,
      'model': instance.model,
      'promptTokens': instance.promptTokens,
      'completionTokens': instance.completionTokens,
      'totalTokens': instance.totalTokens,
    };
