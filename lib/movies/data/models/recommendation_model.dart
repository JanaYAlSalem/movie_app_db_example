import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  RecommendationModel({required int id,required String backdropPath}) : super(id: id,backdropPath: backdropPath);
  // const RecommendationModel({
  //   super.backdropPath,
  //   required super.id,
  // });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        id: json["id"],
        backdropPath:
        json["backdrop_path"] ?? '/ta17TltHGdZ5PZz6oUD3N5BRurb.jpg',
      );
}