import 'package:dartz/dartz.dart';
import 'package:movie_app_db_example/core/error/failure.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/repository/base_movies_repository.dart';

class GetNowPlayingMoviesUseCase
    extends BaseUseCase<List<Movie>, NoParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetNowPlayingMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getNowPlayingMovies();
  }
}