import 'package:dartz/dartz.dart';
import 'package:movie_app_db_example/core/error/exceptions.dart';
import 'package:movie_app_db_example/core/error/failure.dart';
import 'package:movie_app_db_example/movies/data/datasource/local/database/movie_local_data_source.dart';
import 'package:movie_app_db_example/movies/data/datasource/remote/movie_remote_data_source.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie_detail.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_movie_details_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_recommendation_usecase.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;
  final BaseMovieLocalDataSource baseMovieLocalDataSource;

  MoviesRepository(
      this.baseMovieRemoteDataSource, this.baseMovieLocalDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final result = await baseMovieRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    final result = await baseMovieRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters) async {
    final result =
    await baseMovieRemoteDataSource.getRecommendation(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> addFavoriteMovies(
      MovieModel favoriteMovie) async {
    final result =
    await baseMovieLocalDataSource.addFavoriteMovies(favoriteMovie);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFavoriteMovies(int id) async {
    final result = await baseMovieLocalDataSource.deleteFavoriteMovies(id);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<MovieModelDB>>> getAllFavoriteMovies() async {
    final result = await baseMovieLocalDataSource.getAllFavoriteMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavoriteMovie(int id) async {
    final result = await baseMovieLocalDataSource.isFavoriteMovie(id);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
