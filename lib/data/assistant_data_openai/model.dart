import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable(explicitToJson: true)
class Model {
  final String? id;
  final String? object;
  final int? created;
  @JsonKey(name: 'owned_by')
  final String? ownedBy;

  const Model({
    this.id,
    this.object,
    this.created,
    this.ownedBy,
  });

  factory Model.fromJson(Map<String, dynamic> json) =>
      _$ModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
