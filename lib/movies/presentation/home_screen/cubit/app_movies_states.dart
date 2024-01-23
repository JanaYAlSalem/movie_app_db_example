part of 'app_movies_cubit.dart';

@immutable
abstract class AppMoviesStates extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

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

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}

// GetPopularMovies
class GetPopularMoviesLoadingState extends AppMoviesStates {}
class GetPopularMoviesSuccessState extends AppMoviesStates {}
class GetPopularMoviesErrorState extends AppMoviesStates {
  final String error;
  GetPopularMoviesErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];

}

// GetTopRatedMovies
class GetTopRatedMoviesLoadingState extends AppMoviesStates {}
class GetTopRatedMoviesSuccessState extends AppMoviesStates {}
class GetTopRatedMoviesErrorState extends AppMoviesStates {
  final String error;
  GetTopRatedMoviesErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}


