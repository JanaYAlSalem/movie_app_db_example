import 'dart:io';
import 'package:isar/isar.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseMovieLocalDataSource {
  Future<bool> addFavoriteMovies(MovieModel favoriteMovie);

  Future<bool> deleteFavoriteMovies(int id);

  Future<List<MovieModelDB>> getAllFavoriteMovies();

  Future<bool> isFavoriteMovie(int id);
}

class MovieLocalDataSource extends BaseMovieLocalDataSource {
  late Future<Isar> isarDB;

  MovieLocalDataSource() {
    isarDB = openD();
  }

  Future<Isar> openD() async {
    if (Isar.instanceNames.isEmpty) {
      final Directory dir = await getApplicationSupportDirectory();
      if (dir.existsSync()) {
        return await Isar.open([MovieModelDBSchema],
            inspector: true, directory: dir.path);
      }
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> addFavoriteMovies(MovieModel favoriteMovie) async {
    MovieModelDB newMovie = MovieModelDB()
      ..idMovieModel = favoriteMovie.id
      ..title = favoriteMovie.title
      ..overview = favoriteMovie.overview
      ..backdropPath = favoriteMovie.backdropPath
      ..releaseDate = favoriteMovie.releaseDate
      ..genreIds = favoriteMovie.genreIds
      ..voteAverage = favoriteMovie.voteAverage;
    final isar = await isarDB;
    try {
      await isar.writeTxnSync(() => isar.movieModelDBs.putSync(newMovie));
      print("MovieLocalDataSource,deleteFavoriteMovies:  added successfully");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteFavoriteMovies(int id) async {
    final isar = await isarDB;

    try {
      await isar.writeTxn(() async {
        await isar.movieModelDBs.filter().idMovieModelEqualTo(id).deleteFirst();
      });
      print("MovieLocalDataSource,deleteFavoriteMovies: deleted successfully");
      return false;
    } catch (e) {
      return true;
    }
  }

  @override
  Future<List<MovieModelDB>> getAllFavoriteMovies() async {
    final isar = await isarDB;
    final favoritMovies = isar.movieModelDBs.where().findAll();
    print(favoritMovies);
    return favoritMovies;
  }

  @override
  Future<bool> isFavoriteMovie(int id) async {
    final isar = await isarDB;
    final s =
        await isar.movieModelDBs.filter().idMovieModelEqualTo(id).findAll();
    if (s.isNotEmpty) {
      print("2- MovieLocalDataSource isFavoriteMovie :true, should be deleted");
      return true;
    } else {
      print("2- MovieLocalDataSource isFavoriteMovie :false, should be added");
      return false;
      // add
    }
  }
}
