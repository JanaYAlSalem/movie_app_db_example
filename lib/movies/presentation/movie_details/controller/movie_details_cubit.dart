import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/controller/movie_details_bloc.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit() : super(MovieDetailsInitialState());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  bool isFavorite = false;

}