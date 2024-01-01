import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_db_example/core/network/api_constance.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';
import 'package:movie_app_db_example/core/utils/enums.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/domain/entities/genres.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/controller/movie_details_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen(Movie movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicesLocator<AppMoviesCubit>(),
      lazy: false,
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMoviesCubit, AppMoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print("MovieDetailContent");
          return Text("data");
        });
  }
}
