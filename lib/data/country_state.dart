import 'package:json_annotation/json_annotation.dart';

import 'country.dart';
part 'country_state.g.dart';
@JsonSerializable()

class CountryState {
  int? id;
  String? name;
  Country? country;

  CountryState(this.id, this.country);

  factory CountryState.fromJson(Map<String, dynamic> json) => _$CountryStateFromJson(json);

  Map<String, dynamic> toJson() => _$CountryStateToJson(this);
}
