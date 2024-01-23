import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/get_favorite_movies_usecase.dart';

part 'favorite_movies_state.dart';

class FavoriteMoviesCubit extends Cubit<FavoriteMoviesState> {
  final GetFavoriteMoviesUseCase getFavoriteMoviesUseCase;

  FavoriteMoviesCubit(
      this.getFavoriteMoviesUseCase,)
      : super(FavoriteMoviesInitial());

  static FavoriteMoviesCubit get(context) => BlocProvider.of(context);

  List<MovieModelDB> favoriteMoviesList = [];

  FutureOr<void> getFavoriteMovies() async {
    emit(GetFavoriteMoviesLoadingState());
    final result = await getFavoriteMoviesUseCase(const NoParameters());
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ FAV GET");
    result.fold(
          (l) => emit(GetFavoriteMoviesErrorState(l.message)),
          (r) {
            favoriteMoviesList = r;
            emit(GetFavoriteMoviesSuccessState());
          }
    );
  }

}
