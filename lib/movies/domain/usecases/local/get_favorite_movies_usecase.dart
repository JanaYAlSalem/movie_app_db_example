import 'package:dartz/dartz.dart';
import 'package:movie_app_db_example/core/error/failure.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/repository/base_movies_repository.dart';

class GetFavoriteMoviesUseCase
    extends BaseUseCase<List<MovieModelDB>, NoParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetFavoriteMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<MovieModelDB>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getAllFavoriteMovies();
  }
}