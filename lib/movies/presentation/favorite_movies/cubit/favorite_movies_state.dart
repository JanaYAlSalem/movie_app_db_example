part of 'favorite_movies_cubit.dart';

@immutable
abstract class FavoriteMoviesState {}

class FavoriteMoviesInitial extends FavoriteMoviesState {}

class GetFavoriteMoviesLoadingState extends FavoriteMoviesState {}
class GetFavoriteMoviesSuccessState extends FavoriteMoviesState {}
class GetFavoriteMoviesErrorState extends FavoriteMoviesState {
  final String error;
  GetFavoriteMoviesErrorState(this.error);
}
