import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/utils/enums.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie_detail.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/add_favorite_movies_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/delete_favorite_movies.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/is_favorite_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_movie_details_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_recommendation_usecase.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(
      this.getMovieDetailsUseCase,
      this.getRecommendationUseCase,
      this.addFavoriteMoviesUseCase,
      this.deleteFavoriteMoviesUseCase,
      this.isFavoriteMoviesUseCase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getRecommendation);
    on<AddFavoriteMoviesEvent>(_addFavoriteMovies);
    on<DeleteFavoriteMoviesEvent>(_deleteFavoriteMovie);
    on<IsFavoriteMovieEvent>(_isFavoriteMovie);
  }

  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;
  final AddFavoriteMoviesUseCase addFavoriteMoviesUseCase;
  final DeleteFavoriteMoviesUseCase deleteFavoriteMoviesUseCase;
  final IsFavoriteMovieUseCase isFavoriteMoviesUseCase;

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await getMovieDetailsUseCase(MovieDetailsParameters(
      movieId: event.id,
    ));

    result.fold(
      (l) => emit(state.copyWith(
        movieDetailsState: RequestState.error,
        movieDetailsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          movieDetail: r,
          movieDetailsState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getRecommendation(GetMovieRecommendationEvent event,
      Emitter<MovieDetailsState> emit) async {
    final result = await getRecommendationUseCase(
      RecommendationParameters(
        event.id,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(
        recommendationState: RequestState.error,
        recommendationMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          recommendation: r,
          recommendationState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _addFavoriteMovies(
      AddFavoriteMoviesEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await addFavoriteMoviesUseCase(MovieModel(
        id: event.movieItem.id,
        title: event.movieItem.title,
        backdropPath: event.movieItem.backdropPath,
        genreIds: event.movieItem.genreIds,
        overview: event.movieItem.overview,
        voteAverage: event.movieItem.voteAverage,
        releaseDate: event.movieItem.releaseDate));
    result.fold(
      (l) => emit(state.copyWith(
        favoriteState: FavoriteState.init,
        favoriteMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          favoriteState: FavoriteState.added,
          isFavorite: true
        ),
      ),
    );
  }

  FutureOr<void> _deleteFavoriteMovie(
      DeleteFavoriteMoviesEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await deleteFavoriteMoviesUseCase(event.id);

    result.fold(
      (l) => emit(state.copyWith(
        favoriteState: FavoriteState.init,
        favoriteMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          favoriteState: FavoriteState.deleted,
          isFavorite: false
        ),
      ),
    );
  }

  FutureOr<void> _isFavoriteMovie(
      IsFavoriteMovieEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await isFavoriteMoviesUseCase(event.id);
    print("1++++++++++++++++++++++${state.isFavorite}");

    result.fold(
      (l) => emit(state.copyWith()),
      (r) => emit(
        state.copyWith(
          isFavorite: r,
        ),
      ),
    );
  }
}
