import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/core/utils/enums.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/get_favorite_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_now_playing_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_popular_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_top_rated_movies_usecase.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movies/movies_event.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movies/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  MoviesBloc(
      this.getNowPlayingMoviesUseCase,
      this.getPopularMoviesUseCase,
      this.getTopRatedMoviesUseCase,
      this.getFavoriteMoviesUseCase
      ) : super(const MoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

    on<GetFavoriteMoviesEvent>(_getFavoriteMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());
    result.fold(
          (l) => emit(state.copyWith(
        nowPlayingState: RequestState.error,
        popularMessage: l.message,
      )),
          (r) => emit(
        state.copyWith(
          nowPlayingMovies: r,
          nowPlayingState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameters());

    result.fold(
          (l) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessage: l.message,
        ),
      ),
          (r) => emit(
        state.copyWith(
          popularMovies: r,
          popularState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());

    result.fold(
          (l) => emit(state.copyWith(
        topRatedMessage: l.message,
        topRatedState: RequestState.error,
      )),
          (r) => emit(
        state.copyWith(
          topRatedMovies: r,
          topRatedState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getFavoriteMovies(
      GetFavoriteMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getFavoriteMoviesUseCase(const NoParameters());

    result.fold(
          (l) => emit(state.copyWith(
        topRatedMessage: l.message,
        topRatedState: RequestState.error,
      )),
          (r) => emit(
        state.copyWith(
          //favoriteMovies: r,
          favoriteState: RequestState.loaded,
        ),
      ),
    );
  }


}