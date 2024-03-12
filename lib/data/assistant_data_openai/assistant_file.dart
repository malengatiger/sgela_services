import 'package:json_annotation/json_annotation.dart';

part 'assistant_file.g.dart';

@JsonSerializable(explicitToJson: true)
class AssistantFile {
  final String? id;
  final String? object;
  final int? bytes;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  final String? filename;
  final String? purpose;
  @JsonKey(name: 'status_details')
  final String? statusDetails;

  const AssistantFile({
    this.id,
    this.object,
    this.bytes,
    this.createdAt,
    this.filename,
    this.purpose,
    this.statusDetails
  });

  factory AssistantFile.fromJson(Map<String, dynamic> json) =>
      _$AssistantFileFromJson(json);

  Map<String, dynamic> toJson() => _$AssistantFileToJson(this);
}
