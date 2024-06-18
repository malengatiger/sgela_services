// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_response_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponseRating _$AIResponseRatingFromJson(Map<String, dynamic> json) =>
    AIResponseRating(
      rating: (json['rating'] as num?)?.toInt(),
      date: json['date'] as String?,
      id: (json['id'] as num?)?.toInt(),
      subjectId: (json['subjectId'] as num?)?.toInt(),
      organizationId: (json['organizationId'] as num?)?.toInt(),
      numberOfPagesInQuery: (json['numberOfPagesInQuery'] as num?)?.toInt(),
      sponsoreeId: (json['sponsoreeId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      sponsoreeName: json['sponsoreeName'] as String?,
      sponsoreeEmail: json['sponsoreeEmail'] as String?,
      sponsoreeCellphone: json['sponsoreeCellphone'] as String?,
      examLinkId: (json['examLinkId'] as num?)?.toInt(),
      examTitle: json['examTitle'] as String?,
      subject: json['subject'] as String?,
      aiModel: json['aiModel'] as String?,
    )..tokensUsed = (json['tokensUsed'] as num?)?.toInt();

Map<String, dynamic> _$AIResponseRatingToJson(AIResponseRating instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'date': instance.date,
      'id': instance.id,
      'subjectId': instance.subjectId,
      'organizationId': instance.organizationId,
      'numberOfPagesInQuery': instance.numberOfPagesInQuery,
      'sponsoreeId': instance.sponsoreeId,
      'userId': instance.userId,
      'sponsoreeName': instance.sponsoreeName,
      'sponsoreeEmail': instance.sponsoreeEmail,
      'sponsoreeCellphone': instance.sponsoreeCellphone,
      'examLinkId': instance.examLinkId,
      'examTitle': instance.examTitle,
      'subject': instance.subject,
      'aiModel': instance.aiModel,
      'tokensUsed': instance.tokensUsed,
    };
