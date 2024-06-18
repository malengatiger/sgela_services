// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Run _$RunFromJson(Map<String, dynamic> json) => Run(
      json['id'] as String?,
      json['instructions'] as String?,
      json['model'] as String?,
      $enumDecodeNullable(_$StatusEnumMap, json['status']),
      json['object'] as String?,
      json['assistant_id'] as String?,
      json['thread_id'] as String?,
      (json['cancelled_at'] as num?)?.toInt(),
      (json['completed_at'] as num?)?.toInt(),
      (json['created_at'] as num?)?.toInt(),
      (json['expires_at'] as num?)?.toInt(),
      (json['failed_at'] as num?)?.toInt(),
      json['required_action'] as String?,
      json['tools'],
      json['usage'],
      (json['file_ids'] as List<dynamic>).map((e) => e as String).toList(),
      (json['started_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RunToJson(Run instance) => <String, dynamic>{
      'id': instance.id,
      'instructions': instance.instructions,
      'model': instance.model,
      'object': instance.object,
      'assistant_id': instance.assistantId,
      'thread_id': instance.threadId,
      'cancelled_at': instance.cancelledAt,
      'completed_at': instance.completedAt,
      'created_at': instance.createdAt,
      'expires_at': instance.expiresAt,
      'failed_at': instance.failedAt,
      'required_action': instance.requiredAction,
      'started_at': instance.startedAt,
      'tools': instance.tools,
      'usage': instance.usage,
      'file_ids': instance.fileIds,
      'status': _$StatusEnumMap[instance.status],
    };

const _$StatusEnumMap = {
  Status.queued: 'queued',
  Status.cancelling: 'cancelling',
  Status.cancelled: 'cancelled',
  Status.failed: 'failed',
  Status.completed: 'completed',
  Status.expired: 'expired',
  Status.in_progress: 'in_progress',
  Status.requires_action: 'requires_action',
};
