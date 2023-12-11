import 'package:dartz/dartz.dart';
import 'package:movie_app_db_example/core/error/failure.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/repository/base_movies_repository.dart';

class AddFavoriteMoviesUseCase extends BaseUseCase<void, MovieModel> {
  final BaseMoviesRepository baseMoviesRepository;

  AddFavoriteMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, void>> call(MovieModel parameters) async {
    return await baseMoviesRepository.addFavoriteMovies(parameters);
  }


}