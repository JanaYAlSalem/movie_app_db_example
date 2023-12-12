part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  final int id;

  const GetMovieDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetMovieRecommendationEvent extends MovieDetailsEvent {
  final int id;

  const GetMovieRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddFavoriteMoviesEvent extends MovieDetailsEvent {
  final MovieModel movieItem;

  const AddFavoriteMoviesEvent(this.movieItem);

  @override
  List<Object> get props => [movieItem];
}

class DeleteFavoriteMoviesEvent extends MovieDetailsEvent {
  final int id;

  const DeleteFavoriteMoviesEvent(this.id);

  @override
  List<Object> get props => [id];
}

class IsFavoriteMovieEvent extends MovieDetailsEvent {
  final int id;

  const IsFavoriteMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}
