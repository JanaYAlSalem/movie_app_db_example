import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_db_example/core/network/api_constance.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';
import 'package:movie_app_db_example/core/utils/theme/color.dart';
import 'package:movie_app_db_example/movies/domain/entities/genres.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/controller/movie_details_cubit.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => servicesLocator<MovieDetailsCubit>(),
        lazy: false,
        child: Scaffold(
            appBar: AppBar(
              title: Text(movie.title),
            ),
            body: BlocConsumer<AppMoviesCubit, AppMoviesStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        expandedHeight: 250.0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: FadeIn(
                            duration: const Duration(milliseconds: 500),
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.5, 1.0, 1.0],
                                ).createShader(
                                  Rect.fromLTRB(
                                      0.0, 0.0, rect.width, rect.height),
                                );
                              },
                              blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: FadeInUp(
                          from: 20,
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(movie.title,
                                          maxLines: 5,
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.poppins(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.2,
                                          )),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        MovieDetailsCubit.get(context).addFavoriteMovies(movie);
                                      },
                                      color: AppColors.gray20,
                                      icon: const Icon(Icons.favorite),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 8.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            4.0),
                                      ),
                                      child: Text(
                                        movie.releaseDate.split(
                                            '-')[0],
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 20.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          (movie.voteAverage / 2)
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          '(${movie.voteAverage})',
                                          style: const TextStyle(
                                            fontSize: 1.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  movie.overview,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                // Text(
                                //   'Genres: ${_showGenres(
                                //       state.movieDetail!.genres)}',
                                //   style: const TextStyle(
                                //     color: Colors.white70,
                                //     fontSize: 12.0,
                                //     fontWeight: FontWeight.w500,
                                //     letterSpacing: 1.2,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                            16.0, 16.0, 16.0, 24.0),
                        sliver: SliverToBoxAdapter(
                          child: FadeInUp(
                            from: 20,
                            duration: const Duration(milliseconds: 500),
                            child: const Text(
                              "More like this",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // if(GetRecommendationMoviesSuccessState())
                      state == GetRecommendationMoviesSuccessState() ?
                      // AppMoviesCubit.get(context).recommendationMoviesList.isNotEmpty
                      //     ?
                      SliverPadding(
                        padding:
                        const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                        sliver: _showRecommendations(AppMoviesCubit.get(context).recommendationMoviesList),
                      )
                          : SizedBox(),
                    ],
                  );
                }
            )));
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations(List<Recommendation> recommendation) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return InkWell(
            onTap: () {},
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: CachedNetworkImage(
                    imageUrl: ApiConstance.imageUrl(
                        recommendation[index].backdropPath!),
                    placeholder: (context, url) =>
                        Shimmer.fromColors(
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
                    height: 180.0,
                    fit: BoxFit.cover,
                  )),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
    );
  }
}
