import 'package:get_it/get_it.dart';
import 'package:movie_app_db_example/movies/data/datasource/movie_local_data_source.dart';
import 'package:movie_app_db_example/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movie_app_db_example/movies/data/repository/movies_repository.dart';
import 'package:movie_app_db_example/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/add_favorite_movies_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/delete_favorite_movies.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/get_favorite_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/is_favorite_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_movie_details_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_now_playing_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_popular_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_recommendation_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_top_rated_movies_usecase.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movie_details/movie_details_bloc.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movies/movies_bloc.dart';

final servicesLocator = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Bloc
    servicesLocator.registerFactory(() => MoviesBloc(servicesLocator(),
        servicesLocator(), servicesLocator(), servicesLocator()));
    servicesLocator.registerFactory(() => MovieDetailsBloc(servicesLocator(),
        servicesLocator(), servicesLocator(),servicesLocator(),servicesLocator()));

    /// Remote Use Cases
    servicesLocator.registerLazySingleton(
        () => GetNowPlayingMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(
        () => GetPopularMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(
        () => GetTopRatedMoviesUseCase(servicesLocator()));
    servicesLocator
        .registerLazySingleton(() => GetMovieDetailsUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(
        () => GetRecommendationUseCase(servicesLocator()));

    // Local Use Cases
    servicesLocator.registerLazySingleton(() => GetFavoriteMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(() => AddFavoriteMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(() => DeleteFavoriteMoviesUseCase(servicesLocator()));
    servicesLocator.registerLazySingleton(() => IsFavoriteMovieUseCase(servicesLocator()));

    /// Repository
    servicesLocator.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(servicesLocator(), servicesLocator()));

    /// DATA SOURCE
    servicesLocator.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());
    servicesLocator.registerFactory<BaseMovieLocalDataSource>(
        () => MovieLocalDataSource());
  }
}
