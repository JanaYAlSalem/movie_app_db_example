import 'package:movie_app_db_example/movies/data/models/genres_model.dart';
import 'package:movie_app_db_example/movies/domain/entities/genres.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie_detail.dart';

class MovieDetailsModel extends MovieDetail {
  MovieDetailsModel(
      {required String backdropPath,
      required List<Genres> genres,
      required int id,
      required String overview,
      required String releaseDate,
      required int runtime,
      required String title,
      required double voteAverage})
      : super(
            backdropPath: backdropPath,
            genres: genres,
            id: id,
            overview: overview,
            releaseDate: releaseDate,
            runtime: runtime,
            title: title,
            voteAverage: voteAverage);
// const MovieDetailsModel({
//   required super.backdropPath,
//   required super.genres,
//   required super.id,
//   required super.overview,
//   required super.releaseDate,
//   required super.runtime,
//   required super.title,
//   required super.voteAverage,
// });

factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      backdropPath: json["backdrop_path"],
      genres: List<GenresModel>.from(json["genres"].map((x) => GenresModel.fromJson(x))),
      id: json["id"],
      overview: json["overview"],
      releaseDate: json["release_date"],
      runtime: json["runtime"],
      title: json["title"],
      voteAverage: json["vote_average"].toDouble(),
    );
}
