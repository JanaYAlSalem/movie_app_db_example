part of 'movie_details_bloc.dart';

// class MovieDetailsState extends Equatable {
//   const MovieDetailsState(
//       {this.movieDetail,
//       this.movieDetailsState = RequestState.loading,
//       this.movieDetailsMessage = '',
//       this.recommendation = const [],
//       this.recommendationState = RequestState.loading,
//       this.recommendationMessage = '',
//       this.isFavorite = false,
//         this.favoriteMessage = ""
//       });
//
//   final MovieDetail? movieDetail;
//   final RequestState movieDetailsState;
//   final String movieDetailsMessage;
//
//   final List<Recommendation> recommendation;
//   final RequestState recommendationState;
//   final String recommendationMessage;
//
//   final bool isFavorite;
//   final String favoriteMessage;
//
//   MovieDetailsState copyWith(
//       {MovieDetail? movieDetail,
//       RequestState? movieDetailsState,
//       String? movieDetailsMessage,
//       List<Recommendation>? recommendation,
//       RequestState? recommendationState,
//       String? recommendationMessage,
//       bool? isFavorite,
//       String? favoriteMessage}) {
//     return MovieDetailsState(
//         movieDetail: movieDetail ?? this.movieDetail,
//         movieDetailsState: movieDetailsState ?? this.movieDetailsState,
//         movieDetailsMessage: movieDetailsMessage ?? this.movieDetailsMessage,
//         recommendation: recommendation ?? this.recommendation,
//         recommendationState: recommendationState ?? this.recommendationState,
//         recommendationMessage:
//             recommendationMessage ?? this.recommendationMessage,
//         isFavorite: isFavorite ?? this.isFavorite,
//         favoriteMessage : favoriteMessage ?? this.favoriteMessage
//     );
//   }
//
//   @override
//   List<Object?> get props => [
//         movieDetail,
//         movieDetailsState,
//         movieDetailsMessage,
//
//         recommendation,
//         recommendationState,
//         recommendationMessage,
//
//         isFavorite,
//         favoriteMessage
//
//       ];
// }

abstract class MovieDetailsStates {}

class MovieDetailsInitialState extends MovieDetailsStates {}
