import 'package:isar/isar.dart';

part 'movies_model_db.g.dart';

@collection
class MovieModelDB {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  late int idMovieModel;
  late String title;
  late String overview;
  late String backdropPath;
}
