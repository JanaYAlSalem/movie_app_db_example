import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MovieDetailsStates extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class MovieDetailsInitialState extends MovieDetailsStates {}

// data base states
class AppCreateDatabaseState extends MovieDetailsStates {}

class GetDatabaseLoadingState extends MovieDetailsStates {}
class GetDatabaseSuccessState extends MovieDetailsStates {}
class GetDatabaseErrorState extends MovieDetailsStates {
  final String error;
  GetDatabaseErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}

class InsertMovieToDatabaseLoadingState extends MovieDetailsStates {}
class InsertMovieToDatabaseSuccessState extends MovieDetailsStates {}
class InsertMovieToDatabaseErrorState extends MovieDetailsStates {
  final String error;
  InsertMovieToDatabaseErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}

class DeleteMovieToDatabaseLoadingState extends MovieDetailsStates {}
class DeleteMovieToDatabaseSuccessState extends MovieDetailsStates {}
class DeleteMovieToDatabaseErrorState extends MovieDetailsStates {
  final String error;
  DeleteMovieToDatabaseErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}

class IsFavoriteMovieLoadingState extends MovieDetailsStates {}
class IsFavoriteMovieSuccessState extends MovieDetailsStates {}
class IsFavoriteMovieErrorState extends MovieDetailsStates {
  final String error;
  IsFavoriteMovieErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}

class GetFavoriteMoviesLoadingState extends MovieDetailsStates {}
class GetFavoriteMoviesSuccessState extends MovieDetailsStates {}
class GetFavoriteMoviesErrorState extends MovieDetailsStates {
  final String error;
  GetFavoriteMoviesErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}


// GetRecommendation
class GetRecommendationMoviesLoadingState extends MovieDetailsStates {}
class GetRecommendationMoviesSuccessState extends MovieDetailsStates {}
class GetRecommendationMoviesErrorState extends MovieDetailsStates {
  final String error;
  GetRecommendationMoviesErrorState(this.error);

  @override
  List<Object> get props => [
    error,
    identityHashCode(this),
  ];
}
