import 'package:json_annotation/json_annotation.dart';

part 'hot_and_new_response.g.dart';

@JsonSerializable()
class HotAndNewResponse {
  int? page;
  List<HotAndNewData> results;

  HotAndNewResponse({
    this.page,
    this.results = const [],
  });

  factory HotAndNewResponse.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewResponseToJson(this);
}

@JsonSerializable()
class HotAndNewData {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  int? id;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_name')
  String? originalName;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  String? title;

  HotAndNewData({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.originalName,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
  });

  factory HotAndNewData.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewDataToJson(this);
}
