import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/network/api_constance.dart';
import 'package:movie_app_db_example/core/utils/enums.dart';
import 'package:movie_app_db_example/movies/presentation/movies/controller/movies_bloc.dart';
import 'package:movie_app_db_example/movies/presentation/movies/controller/movies_state.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
        buildWhen: (previous, current) =>
            previous.favoriteState != current.favoriteState,
        builder: (context, state) {
          switch (state.favoriteState) {
            case RequestState.loading:
              return const SizedBox(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case RequestState.loaded:
              return FadeIn(
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  height: 170.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: state.favoriteMovies.length,
                    itemBuilder: (context, index) {
                      final movie = state.favoriteMovies[index];
                      return Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MovieDetailScreen(
                                      id: movie.idMovieModel,
                                    ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            child: CachedNetworkImage(
                              width: 120.0,
                              fit: BoxFit.cover,
                              imageUrl:
                                  ApiConstance.imageUrl(movie.backdropPath),
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
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            case RequestState.error:
              return SizedBox(
                height: 400.0,
                child: Center(
                  child: Text(state.nowPlayingMessage),
                ),
              );
          }
        });
  }
}
