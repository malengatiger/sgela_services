import 'package:json_annotation/json_annotation.dart';

part 'run_details.g.dart';

@JsonSerializable(explicitToJson: true)
class RunDetails {
  final String? id;
  final String? object;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'assistant_id')
  final String? assistantId;
  @JsonKey(name: 'thread_id')
  final String? threadId;
  final String? status;
  @JsonKey(name: 'started_at')
  final int? startedAt;
  @JsonKey(name: 'expires_at')
  final dynamic expiresAt;
  @JsonKey(name: 'cancelled_at')
  final dynamic cancelledAt;
  @JsonKey(name: 'failed_at')
  final dynamic failedAt;
  @JsonKey(name: 'completed_at')
  final int? completedAt;
  @JsonKey(name: 'last_error')
  final dynamic lastError;
  final String? model;
  final dynamic instructions;
  final List<RunTools>? tools;
  @JsonKey(name: 'file_ids')
  final List<String>? fileIds;
  final Metadata? metadata;
  final Usage? usage;

  const RunDetails({
    this.id,
    this.object,
    this.createdAt,
    this.assistantId,
    this.threadId,
    this.status,
    this.startedAt,
    this.expiresAt,
    this.cancelledAt,
    this.failedAt,
    this.completedAt,
    this.lastError,
    this.model,
    this.instructions,
    this.tools,
    this.fileIds,
    this.metadata,
    this.usage,
  });

  factory RunDetails.fromJson(Map<String, dynamic> json) =>
      _$RunDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RunDetailsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RunTools {
  final String? type;

  const RunTools({
    this.type,
  });

  factory RunTools.fromJson(Map<String, dynamic> json) =>
      _$RunToolsFromJson(json);

  Map<String, dynamic> toJson() => _$RunToolsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Metadata {
  dynamic metadata;


  Metadata(this.metadata);

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Usage {
  @JsonKey(name: 'prompt_tokens')
  final int? promptTokens;
  @JsonKey(name: 'completion_tokens')
  final int? completionTokens;
  @JsonKey(name: 'total_tokens')
  final int? totalTokens;

  const Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) =>
      _$UsageFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJson(this);
}
