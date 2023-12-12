import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:movie_app_db_example/core/error/failure.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie_detail.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_movie_details_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_recommendation_usecase.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetail>> getMovieDetails(
      MovieDetailsParameters parameters);

  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters);

  Future<Either<Failure, void>> addFavoriteMovies(MovieModel favoriteMovie);

  Future<Either<Failure, void>> deleteFavoriteMovies(int id);

  Future<Either<Failure, List<MovieModelDB>>> getAllFavoriteMovies();

  Future<Either<Failure, bool>> isFavoriteMovie(int id);
}
