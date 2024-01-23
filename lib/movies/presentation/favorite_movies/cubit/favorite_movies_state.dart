part of 'favorite_movies_cubit.dart';

abstract class FavoriteMoviesState extends Equatable {
  @override
  List<Object> get props => [identityHashCode(this)];
}

class FavoriteMoviesInitial extends FavoriteMoviesState {}

class GetFavoriteMoviesLoadingState extends FavoriteMoviesState {}

class GetFavoriteMoviesSuccessState extends FavoriteMoviesState {}

class GetFavoriteMoviesErrorState extends FavoriteMoviesState {
  final String error;

  GetFavoriteMoviesErrorState(this.error);

  @override
  List<Object> get props => [
        error,
        identityHashCode(this),
      ];
}
