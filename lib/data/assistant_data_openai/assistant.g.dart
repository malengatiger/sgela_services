// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenAIAssistant _$OpenAIAssistantFromJson(Map<String, dynamic> json) =>
    OpenAIAssistant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      instructions: json['instructions'] as String?,
      tools: (json['tools'] as List<dynamic>?)
          ?.map((e) => Tools.fromJson(e as Map<String, dynamic>))
          .toList(),
      model: json['model'] as String?,
      subjectId: json['subjectId'] as int?,
      date: json['date'] as String?,
      fileIds:
          (json['file_ids'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'],
      description: json['description'] as String?,
      examLinkId: json['examLinkId'] as int?,
      examLinkTitle: json['examLinkTitle'] as String?,
      subjectTitle: json['subjectTitle'] as String?,
    );

Map<String, dynamic> _$OpenAIAssistantToJson(OpenAIAssistant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'instructions': instance.instructions,
      'tools': instance.tools?.map((e) => e.toJson()).toList(),
      'model': instance.model,
      'subjectId': instance.subjectId,
      'date': instance.date,
      'subjectTitle': instance.subjectTitle,
      'file_ids': instance.fileIds,
      'metadata': instance.metadata,
      'description': instance.description,
      'examLinkTitle': instance.examLinkTitle,
      'examLinkId': instance.examLinkId,
    };

Tools _$ToolsFromJson(Map<String, dynamic> json) => Tools(
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ToolsToJson(Tools instance) => <String, dynamic>{
      'type': instance.type,
    };
