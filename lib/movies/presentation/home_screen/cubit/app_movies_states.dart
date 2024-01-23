part of 'app_movies_cubit.dart';

@immutable
abstract class AppMoviesStates {}

class AppMoviesInitialState extends AppMoviesStates {}
class AppChangeBottomNabBarState extends AppMoviesStates {}
class AppChangeModeState extends AppMoviesStates {}



// api's states

//GetNowPlayingMovies
class GetNowPlayingMoviesLoadingState extends AppMoviesStates {}
class GetNowPlayingMoviesSuccessState extends AppMoviesStates {}
class GetNowPlayingMoviesErrorState extends AppMoviesStates {
  final String error;
  GetNowPlayingMoviesErrorState(this.error);
}

// GetPopularMovies
class GetPopularMoviesLoadingState extends AppMoviesStates {}
class GetPopularMoviesSuccessState extends AppMoviesStates {}
class GetPopularMoviesErrorState extends AppMoviesStates {
  final String error;
  GetPopularMoviesErrorState(this.error);
}

// GetTopRatedMovies
class GetTopRatedMoviesLoadingState extends AppMoviesStates {}
class GetTopRatedMoviesSuccessState extends AppMoviesStates {}
class GetTopRatedMoviesErrorState extends AppMoviesStates {
  final String error;
  GetTopRatedMoviesErrorState(this.error);
}


