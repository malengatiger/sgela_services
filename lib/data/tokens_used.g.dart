// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens_used.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensUsed _$TokensUsedFromJson(Map<String, dynamic> json) => TokensUsed(
      organizationId: (json['organizationId'] as num?)?.toInt(),
      sponsoreeId: (json['sponsoreeId'] as num?)?.toInt(),
      date: json['date'] as String?,
      sponsoreeName: json['sponsoreeName'] as String?,
      organizationName: json['organizationName'] as String?,
      model: json['model'] as String?,
      promptTokens: (json['promptTokens'] as num?)?.toInt(),
      completionTokens: (json['completionTokens'] as num?)?.toInt(),
      totalTokens: (json['totalTokens'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TokensUsedToJson(TokensUsed instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'sponsoreeId': instance.sponsoreeId,
      'date': instance.date,
      'sponsoreeName': instance.sponsoreeName,
      'organizationName': instance.organizationName,
      'model': instance.model,
      'totalTokens': instance.totalTokens,
      'promptTokens': instance.promptTokens,
      'completionTokens': instance.completionTokens,
    };
