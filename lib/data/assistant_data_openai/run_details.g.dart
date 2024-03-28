// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunDetails _$RunDetailsFromJson(Map<String, dynamic> json) => RunDetails(
      id: json['id'] as String?,
      object: json['object'] as String?,
      createdAt: json['created_at'] as int?,
      assistantId: json['assistant_id'] as String?,
      threadId: json['thread_id'] as String?,
      status: json['status'] as String?,
      startedAt: json['started_at'] as int?,
      expiresAt: json['expires_at'],
      cancelledAt: json['cancelled_at'],
      failedAt: json['failed_at'],
      completedAt: json['completed_at'] as int?,
      lastError: json['last_error'],
      model: json['model'] as String?,
      instructions: json['instructions'],
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => RunTools.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileIds: (json['file_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RunDetailsToJson(RunDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created_at': instance.createdAt,
      'assistant_id': instance.assistantId,
      'thread_id': instance.threadId,
      'status': instance.status,
      'started_at': instance.startedAt,
      'expires_at': instance.expiresAt,
      'cancelled_at': instance.cancelledAt,
      'failed_at': instance.failedAt,
      'completed_at': instance.completedAt,
      'last_error': instance.lastError,
      'model': instance.model,
      'instructions': instance.instructions,
      'tools': instance.tools?.map((e) => e.toJson()).toList(),
      'file_ids': instance.fileIds,
      'metadata': instance.metadata?.toJson(),
      'usage': instance.usage?.toJson(),
    };

RunTools _$RunToolsFromJson(Map<String, dynamic> json) => RunTools(
      type: json['type'] as String?,
    );

Map<String, dynamic> _$RunToolsToJson(RunTools instance) => <String, dynamic>{
      'type': instance.type,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      json['metadata'],
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'metadata': instance.metadata,
    };

Usage _$UsageFromJson(Map<String, dynamic> json) => Usage(
      promptTokens: json['prompt_tokens'] as int?,
      completionTokens: json['completion_tokens'] as int?,
      totalTokens: json['total_tokens'] as int?,
    );

Map<String, dynamic> _$UsageToJson(Usage instance) => <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };
