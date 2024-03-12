import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@JsonSerializable(explicitToJson: true)
class Thread {
   String? id;
   String? object;
  @JsonKey(name: 'created_at')
   int? createdAt;
   dynamic metadata;

   Thread({
    required this.id,
    required this.object,
    required this.createdAt,
    required this.metadata,
  });

  factory Thread.fromJson(Map<String, dynamic> json) =>
      _$ThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadToJson(this);
}
