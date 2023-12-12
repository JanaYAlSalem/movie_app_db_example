part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState(
      {this.movieDetail,
        this.movieDetailsState = RequestState.loading,
        this.movieDetailsMessage = '',
        this.recommendation = const [],
        this.recommendationState = RequestState.loading,
        this.recommendationMessage = '',
        this.test = true});

  final MovieDetail? movieDetail;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;
  final List<Recommendation> recommendation;
  final RequestState recommendationState;
  final String recommendationMessage;

  //todo : for test
  final bool test;

  MovieDetailsState copyWith(
      {MovieDetail? movieDetail,
        RequestState? movieDetailsState,
        String? movieDetailsMessage,
        List<Recommendation>? recommendation,
        RequestState? recommendationState,
        String? recommendationMessage,
        bool? test}) {
    return MovieDetailsState(
        movieDetail: movieDetail ?? this.movieDetail,
        movieDetailsState: movieDetailsState ?? this.movieDetailsState,
        movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
        recommendation: recommendation ?? this.recommendation,
        recommendationState: recommendationState ?? this.recommendationState,
        recommendationMessage:
        recommendationMessage ?? this.recommendationMessage,
        test: test ?? this.test);
  }

  @override
  List<Object?> get props => [
    movieDetail,
    movieDetailsState,
    movieDetailsMessage,
    recommendation,
    recommendationState,
    recommendationMessage,
    test,
  ];
}
