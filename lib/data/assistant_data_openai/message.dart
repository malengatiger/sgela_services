import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  String? id;
  String? object;
  @JsonKey(name: 'created_at')
  int? createdAt;
  @JsonKey(name: 'thread_id')
  String? threadId;
  String? role;
  List<Content>? content;
  @JsonKey(name: 'file_ids')
  List<String>? fileIds;
  @JsonKey(name: 'assistant_id')
  String? assistantId;
  @JsonKey(name: 'run_id')
  String? runId;
  dynamic metadata;

   Message({
    required this.id,
    required this.object,
    required this.createdAt,
    required this.threadId,
    required this.role,
    required this.content,
    required this.fileIds,
    required this.assistantId,
    required this.runId,
    required this.metadata,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  String? type;
  MyText? text;

   Content({
    required this.type,
    required this.text,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MyText {
  String? value;
  List<dynamic>? annotations;

   MyText({
    required this.value,
    required this.annotations,
  });

  factory MyText.fromJson(Map<String, dynamic> json) =>
      _$MyTextFromJson(json);

  Map<String, dynamic> toJson() => _$MyTextToJson(this);
}


