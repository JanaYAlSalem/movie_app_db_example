import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/add_favorite_movies_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/delete_favorite_movies.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/get_favorite_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/is_favorite_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_recommendation_usecase.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/cubit/movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  final AddFavoriteMoviesUseCase addFavoriteMoviesUseCase;
  final DeleteFavoriteMoviesUseCase deleteFavoriteMoviesUseCase;
  final IsFavoriteMovieUseCase isFavoriteMoviesUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;

  MovieDetailsCubit(
      this.addFavoriteMoviesUseCase,
      this.deleteFavoriteMoviesUseCase,
      this.isFavoriteMoviesUseCase,
      this.getRecommendationUseCase)
      : super(MovieDetailsInitialState());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  bool isFavorite = false;
  List<Recommendation> recommendationMoviesList = [];

  FutureOr<void> addFavoriteMovies(Movie movie) async {
    emit(InsertMovieToDatabaseLoadingState());
    final result = await addFavoriteMoviesUseCase(MovieModel(
        id: movie.id,
        title: movie.title,
        backdropPath: movie.backdropPath,
        genreIds: movie.genreIds,
        overview: movie.overview,
        voteAverage: movie.voteAverage,
        releaseDate: movie.releaseDate));

    result.fold((l) => emit(InsertMovieToDatabaseErrorState(l.message)), (r) {
      isFavorite = true;
      emit(InsertMovieToDatabaseSuccessState());
    });
  }

  FutureOr<void> deleteFavoriteMovie(int id) async {
    emit(DeleteMovieToDatabaseLoadingState());
    final result = await deleteFavoriteMoviesUseCase(id);

    result.fold((l) => emit(DeleteMovieToDatabaseErrorState(l.message)), (r) {
      isFavorite = false;
      emit(DeleteMovieToDatabaseSuccessState());
    });
  }

  FutureOr<void> isFavoriteMovie(int id) async {
    emit(IsFavoriteMovieLoadingState());
    final result = await isFavoriteMoviesUseCase(id);

    result.fold(
      (l) => emit(IsFavoriteMovieErrorState(l.message)),
      (r) {
        isFavorite = r;
        emit(IsFavoriteMovieSuccessState());
      },
    );
  }

  FutureOr<void> getRecommendationMovies(int id) async {
    emit(GetRecommendationMoviesLoadingState());
    final result = await getRecommendationUseCase(RecommendationParameters(id));
    result.fold((l) => emit(GetRecommendationMoviesErrorState(l.message)), (r) {
      recommendationMoviesList = r;
      print("getRecommendationMovies ${r}");
      emit(GetRecommendationMoviesSuccessState());
    });
  }
}
