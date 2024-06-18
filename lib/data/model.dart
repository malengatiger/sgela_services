import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(explicitToJson: true)
class Model {
  final String? id;
  final String? displayName;
  final int? created;
  @JsonKey(name: 'owned_by')
  final String? ownedBy;

  const Model({
    this.id,
    this.displayName,
    this.created,
    this.ownedBy,
  });

  factory Model.fromJson(Map<String, dynamic> json) =>
      _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);

  static List<Model> getModels() {
    List<Model> models = [
      Model(id: ' claude-3-haiku-20240307', displayName: 'Haiku'),
      Model(id: ' claude-3-sonnet-20240229', displayName: 'Sonnet'),
      Model(id: ' claude-3-opus-20240229', displayName: 'Opus'),
      Model(id: ' LLEMMA', displayName: 'LLEMMA'),

      Model(id: ' llama3-8b-8192', displayName: 'LLaMA3 8b'),
      Model(id: ' llama3-70b-8192', displayName: 'LLaMA3 70b'),
      Model(id: ' Mixtral 8x7b', displayName: 'Mixtral 8x7b'),
      Model(id: ' gemma-7b-it', displayName: 'Gemma 7b'),

      Model(id: ' gemini-pro', displayName: 'Gemini Pro 1.0'),
      Model(id: ' gemini-pro-vision', displayName: 'Gemini Pro 1.0 Vision'),
      Model(id: ' gemini-1.5-pro-latest', displayName: 'Gemini Pro 1.5'),
    ];

    return models;
  }
}
