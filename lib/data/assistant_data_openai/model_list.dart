import 'package:json_annotation/json_annotation.dart';

import 'model.dart';

part 'model_list.g.dart';

@JsonSerializable(explicitToJson: true)
class ModelList {
  final String? object;
  final List<Model>? data;


  const ModelList({
    this.object,
    this.data,
  });

  factory ModelList.fromJson(Map<String, dynamic> json) =>
      _$ModelListFromJson(json);

  Map<String, dynamic> toJson() => _$ModelListToJson(this);
}
