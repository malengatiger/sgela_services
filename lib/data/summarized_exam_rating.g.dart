// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summarized_exam_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummarizedExamRating _$SummarizedExamRatingFromJson(
        Map<String, dynamic> json) =>
    SummarizedExamRating(
      (json['summarizedExamId'] as num?)?.toInt(),
      (json['ratingOutOfTen'] as num?)?.toInt(),
      json['date'] as String?,
    );

Map<String, dynamic> _$SummarizedExamRatingToJson(
        SummarizedExamRating instance) =>
    <String, dynamic>{
      'summarizedExamId': instance.summarizedExamId,
      'ratingOutOfTen': instance.ratingOutOfTen,
      'date': instance.date,
    };
