import 'package:dartz/dartz.dart';
import 'package:movie_app_db_example/core/error/failure.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/repository/base_movies_repository.dart';

class DeleteFavoriteMoviesUseCase extends BaseUseCase<void, int> {
  final BaseMoviesRepository baseMoviesRepository;

  DeleteFavoriteMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, void>> call(int parameters) async {
    return await baseMoviesRepository.deleteFavoriteMovies(parameters);
  }

}
