import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_db_example/core/network/api_constance.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/presentation/favorite_movies/cubit/favorite_movies_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/cubit/movie_details_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';



class FavoriteMoviesScreen extends StatelessWidget {
  FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMoviesCubit, FavoriteMoviesState>(
        builder: (context, state) {
          return FavoriteMoviesCubit.get(context).favoriteMoviesList.isNotEmpty ?
            GridView.builder(
                itemCount: FavoriteMoviesCubit.get(context).favoriteMoviesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int index) {
                  return _buildItemCardWidget(FavoriteMoviesCubit.get(context).favoriteMoviesList[index],() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MovieDetailScreen(movie:
                            Movie(
                              id: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].id,
                              title: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].title,
                              backdropPath: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].backdropPath,
                              overview: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].overview,
                              releaseDate: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].releaseDate,
                              voteAverage: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].voteAverage,
                              genreIds: FavoriteMoviesCubit.get(context).favoriteMoviesList[index].genreIds,
                            )
                            ),
                      ),
                    );
                  },);
                },
          )
            : const SizedBox();
        }
    );
  }

  Widget _buildItemCardWidget(
      MovieModelDB movie, Function()? onTap) {
    return Container(
      width: 120.0,
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: onTap,
          child: FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
          )),
    );
  }
}
