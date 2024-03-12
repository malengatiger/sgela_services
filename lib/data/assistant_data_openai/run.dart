import 'package:json_annotation/json_annotation.dart';

part 'run.g.dart';

@JsonSerializable(explicitToJson: true)
class Run {
  String? id, instructions, model, object;
  @JsonKey(name: 'assistant_id')
  String? assistantId;
  @JsonKey(name: 'thread_id')
  String? threadId;
  @JsonKey(name: 'cancelled_at')
  int? cancelledAt;
  @JsonKey(name: 'completed_at')
  int? completedAt;
  @JsonKey(name: 'created_at')
  int? createdAt;
  @JsonKey(name: 'expires_at')
  int? expiresAt;
  @JsonKey(name: 'failed_at')
  int? failedAt;
  @JsonKey(name: 'required_action')
  String? requiredAction;
  @JsonKey(name: 'started_at')
  int? startedAt;
  dynamic tools;
  dynamic usage;
  @JsonKey(name: 'file_ids')
  List<String> fileIds = [];
  Status? status;

  Run(
      this.id,
      this.instructions,
      this.model,
      this.status,
      this.object,
      this.assistantId,
      this.threadId,
      this.cancelledAt,
      this.completedAt,
      this.createdAt,
      this.expiresAt,
      this.failedAt,
      this.requiredAction,
      this.tools,
      this.usage,
      this.fileIds,
      this.startedAt);

  factory Run.fromJson(Map<String, dynamic> json) => _$RunFromJson(json);

  Map<String, dynamic> toJson() => _$RunToJson(this);
}
/*
status:
    | 'queued'
    | 'in_progress'
    | 'requires_action'
    | 'cancelling'
    | 'cancelled'
    | 'failed'
    | 'completed'
    | 'expired';

 */
enum Status {
  queued,
  cancelling,
  cancelled,
  failed,
  completed,
  expired,
  in_progress,
  requires_action
}
