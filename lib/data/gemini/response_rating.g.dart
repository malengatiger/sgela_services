// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRating _$ResponseRatingFromJson(Map<String, dynamic> json) =>
    ResponseRating(
      (json['examLinkId'] as num?)?.toInt(),
      (json['rating'] as num?)?.toInt(),
      (json['id'] as num?)?.toInt(),
      json['date'] as String?,
      (json['subjectId'] as num?)?.toInt(),
      json['subjectTitle'] as String?,
      json['responseText'] as String?,
    );

Map<String, dynamic> _$ResponseRatingToJson(ResponseRating instance) =>
    <String, dynamic>{
      'examLinkId': instance.examLinkId,
      'rating': instance.rating,
      'id': instance.id,
      'date': instance.date,
      'subjectId': instance.subjectId,
      'subjectTitle': instance.subjectTitle,
      'responseText': instance.responseText,
    };
