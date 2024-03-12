import 'package:json_annotation/json_annotation.dart';

part 'assistant.g.dart';

@JsonSerializable(explicitToJson: true)
class OpenAIAssistant {
  String? id, name;
  String? instructions;
  List<Tools>? tools;
  String? model;
  int? subjectId;
  String? date, subjectTitle;
  @JsonKey(name: 'file_ids')
  List<String> fileIds;
  dynamic metadata;
  String? description;

  OpenAIAssistant(
      { this.id,
      required this.name,
      required this.instructions,
      required this.tools,
      required this.model,
      this.subjectId,
      this.date,
      required this.fileIds,
      this.metadata,
      required this.description,
      this.subjectTitle});

  factory OpenAIAssistant.fromJson(Map<String, dynamic> json) =>
      _$OpenAIAssistantFromJson(json);

  Map<String, dynamic> toJson() => _$OpenAIAssistantToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Tools {
  String? type;

  Tools({
    required this.type,
  });

  factory Tools.fromJson(Map<String, dynamic> json) => _$ToolsFromJson(json);

  Map<String, dynamic> toJson() => _$ToolsToJson(this);
}
