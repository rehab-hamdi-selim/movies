import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_entity.dart';
part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'overview')
  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  MovieEntity toEntity() => MovieEntity(
    id: id,
    title: title,
    overview: overview,
    posterPath: posterPath ?? '',
    voteAverage: voteAverage,
  );
}
