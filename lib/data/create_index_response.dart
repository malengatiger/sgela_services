import 'package:json_annotation/json_annotation.dart';

part 'create_index_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PineconeIndex {
  final String? name;
  final String? metric;
  final int? dimension;
  final Status? status;
  final String? host;
  final Spec? spec;
  int? examLinkId, subjectId;
  String? examTitle, subject;


  PineconeIndex(this.name, this.metric, this.dimension, this.status, this.host,
      this.spec, this.examLinkId, this.subjectId, this.examTitle, this.subject);

  factory PineconeIndex.fromJson(Map<String, dynamic> json) =>
      _$PineconeIndexFromJson(json);

  Map<String, dynamic> toJson() => _$PineconeIndexToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Status {
  final bool? ready;
  final String? state;

  const Status({
    this.ready,
    this.state,
  });

  factory Status.fromJson(Map<String, dynamic> json) =>
      _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Spec {
  final Serverless? serverless;

  const Spec({
    this.serverless,
  });

  factory Spec.fromJson(Map<String, dynamic> json) =>
      _$SpecFromJson(json);

  Map<String, dynamic> toJson() => _$SpecToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Serverless {
  final String? region;
  final String? cloud;

  const Serverless({
    this.region,
    this.cloud,
  });

  factory Serverless.fromJson(Map<String, dynamic> json) =>
      _$ServerlessFromJson(json);

  Map<String, dynamic> toJson() => _$ServerlessToJson(this);
}
