import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app_db_example/core/usecase/base_usecase.dart';
import 'package:movie_app_db_example/movies/data/datasource/local/shared_preference/shared_preference_manager.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/domain/usecases/local/add_favorite_movies_use_case.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_now_playing_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_popular_movies_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_recommendation_usecase.dart';
import 'package:movie_app_db_example/movies/domain/usecases/remote/get_top_rated_movies_usecase.dart';
import 'package:movie_app_db_example/movies/presentation/all_movies/all_movies_screen.dart';
import 'package:movie_app_db_example/movies/presentation/app_settings/settings_screen.dart';
import 'package:movie_app_db_example/movies/presentation/favorite_movies/favorite_movies_screen.dart';

part 'app_movies_states.dart';

class AppMoviesCubit extends Cubit<AppMoviesStates> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;
  final SharedPreferenceManager sharedPreferenceManager;


  AppMoviesCubit(
      this.getNowPlayingMoviesUseCase,
      this.getPopularMoviesUseCase,
      this.getTopRatedMoviesUseCase,
      this.getRecommendationUseCase,
      this.sharedPreferenceManager)
      : super(AppMoviesInitialState());

  static AppMoviesCubit get(context) => BlocProvider.of(context);

  int bottomNavigationBarIndex = 0;
  List<Movie> nowPlayingMoviesList = [];
  List<Movie> popularMoviesMoviesList = [];
  List<Movie> topRatedMoviesList = [];
  List<Recommendation> recommendationMoviesList = [];
  bool isDark = false;

  List<Widget> appScreens = [const AllMoviesScreen(), FavoriteMoviesScreen(),const SettingsScreen()];

  void changeIndex(int index) {
    bottomNavigationBarIndex = index;
    emit(AppChangeBottomNabBarState());
  }

  FutureOr<void> getNowPlayingMovies() async {
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& HI");
    emit(GetNowPlayingMoviesLoadingState());
    final result = await getNowPlayingMoviesUseCase(const NoParameters());
    result.fold((l) => emit(GetNowPlayingMoviesErrorState(l.message)), (r) {
      nowPlayingMoviesList = r;
      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& ${r}");
      emit(GetNowPlayingMoviesSuccessState());
    });
  }

  FutureOr<void> getPopularMovies() async {
    emit(GetPopularMoviesLoadingState());
    final result = await getPopularMoviesUseCase(const NoParameters());
    result.fold((l) => emit(GetPopularMoviesErrorState(l.message)), (r) {
      popularMoviesMoviesList = r;
      emit(GetPopularMoviesSuccessState());
    });
  }

  FutureOr<void> getTopRatedMovies() async {
    emit(GetTopRatedMoviesLoadingState());
    final result = await getTopRatedMoviesUseCase(const NoParameters());
    result.fold((l) => emit(GetTopRatedMoviesErrorState(l.message)), (r) {
      topRatedMoviesList = r;
      emit(GetTopRatedMoviesSuccessState());
    });
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

  void changeAppMode() {
    isDark = !isDark;
    sharedPreferenceManager
        .setMode(isDark)
        .then((value) => emit(AppChangeModeState()));
  }

  Future<bool> getMode() async {
    isDark = await sharedPreferenceManager.getMode();
    return isDark;
  }


}
