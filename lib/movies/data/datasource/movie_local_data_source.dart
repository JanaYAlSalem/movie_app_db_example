import 'dart:io';
import 'package:isar/isar.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseMovieLocalDataSource {
  Future<void> addFavoriteMovies(MovieModel favoriteMovie);

  Future<void> deleteFavoriteMovies(int id);

  Future<List<MovieModelDB>> getAllFavoriteMovies();

  Future<bool> isFavoriteMovie(int id);
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
    await isar.writeTxn(() async {
      await isar.movieModelDBs.filter().idMovieModelEqualTo(id).deleteFirst();
    });
  }

  // @override
  // Future<IsarCollection<MovieModelDB>> getAllFavoriteMovies() async {
  //
  //   await openDB();
  //   final favoritMovies = isar.movieModelDBs;
  //
  //   print(favoritMovies);
  //   return favoritMovies;
  // }

  @override
  Future<List<MovieModelDB>> getAllFavoriteMovies() async {
    // print("------------ ${isar.isOpen}");
    // if (!isar.isOpen)
    await openDB();
    final favoritMovies = isar.movieModelDBs.where().findAll();
    print(favoritMovies);
    return favoritMovies;
  }




  @override
  Future<bool> isFavoriteMovie(int id) async {
    final s = await isar.movieModelDBs.filter().idMovieModelEqualTo(id).findAll();
    if (s.isNotEmpty) {
      print("########### true");
      return true;
    } else {
      print("########### false");
      return false;
      // add
    }
  }
}
