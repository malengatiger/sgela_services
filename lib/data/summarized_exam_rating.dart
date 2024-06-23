
import 'package:json_annotation/json_annotation.dart';
part 'summarized_exam_rating.g.dart';

@JsonSerializable()
class SummarizedExamRating {
  int? summarizedExamId;
  int? ratingOutOfTen;
  String? date;


  SummarizedExamRating(this.summarizedExamId, this.ratingOutOfTen, this.date);

  factory SummarizedExamRating.fromJson(Map<String, dynamic> json) =>
      _$SummarizedExamRatingFromJson(json);

  Map<String, dynamic> toJson() => _$SummarizedExamRatingToJson(this);
}
