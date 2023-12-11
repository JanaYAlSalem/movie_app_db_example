import 'dart:io';

import 'package:isar/isar.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseMovieLocalDataSource {
  Future<void> addFavoriteMovies(MovieModel favoriteMovie);

  Future<void> deleteFavoriteMovies(int id);

  Future<List<MovieModelDB>> getAllFavoriteMovies();
}

class MovieLocalDataSource extends BaseMovieLocalDataSource {
  late Isar isar;

  openDB() async {
    print("2------------ MovieLocalDataSource");
    final Directory dir = await getApplicationSupportDirectory();
    if (dir.existsSync()) {
      isar = await Isar.open([MovieModelDBSchema], directory: dir.path);
      print("isar : ${isar.path}");
      return isar;
    }
  }

  @override
  Future<void> addFavoriteMovies(MovieModel favoriteMovie) async {
    MovieModelDB newMovie = MovieModelDB()
      ..idMovieModel = favoriteMovie.id
      ..title = favoriteMovie.title
      ..overview = favoriteMovie.overview
      ..backdropPath = favoriteMovie.backdropPath;
    if (!isar.isOpen) await openDB();
    await isar.writeTxnSync(() => isar.movieModelDBs.putSync(newMovie));
  }

  @override
  Future<void> deleteFavoriteMovies(int id) async {
    // final existingUser = await isar.movieModelDBs.get(id); // get
    await isar.movieModelDBs.delete(id);
    throw UnimplementedError();
  }

  @override
  Future<List<MovieModelDB>> getAllFavoriteMovies() async {
    // print("------------ ${isar.isOpen}");
    // if (!isar.isOpen)
    await openDB();
    // final favoritMovies = isar.movieModelDBs;
    throw UnimplementedError();
  }
}
