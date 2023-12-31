import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_db_example/core/network/api_constance.dart';
import 'package:movie_app_db_example/core/utils/enums.dart';
import 'package:movie_app_db_example/movies/data/models/movie_model.dart';
import 'package:movie_app_db_example/movies/domain/entities/genres.dart';
import 'package:movie_app_db_example/movies/domain/entities/recommendation.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/controller/movie_details_bloc.dart';
import 'package:movie_app_db_example/movies/presentation/movies/screens/movies_screen.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: (context) => servicesLocator<MovieDetailsBloc>()
      // create: (context) => context.read<MovieDetailsBloc>()
      // create: (context) => MovieDetailsBloc.get(context)
      // create: (context) => BlocProvider.of<MovieDetailsBloc>(context)
        create: (context) => MovieDetailsBloc()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieRecommendationEvent(id))
        ..add(IsFavoriteMovieEvent(id)),
      lazy: false,
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}

Color buttonColor = Colors.grey;

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
      listener: (context, state) {
        print("BlocConsumer : listener ----------- ${state.isFavorite}");
        buttonColor = state.isFavorite ? Colors.red : Colors.grey;
      },
      builder: (context, state) {
        final recommendation = state.recommendation;
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const MoviesScreen(),
                          ));
                      // Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.grey,
                    ),
                  ),
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
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: ApiConstance.imageUrl(
                              state.movieDetail!.backdropPath),
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
                                child: Text(state.movieDetail!.title,
                                    maxLines: 5,
                                    overflow: TextOverflow.visible,
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    )),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () async {
                                  if (state.isFavorite) {
                                    BlocProvider.of<MovieDetailsBloc>(context).add(
                                        DeleteFavoriteMoviesEvent(
                                            state.movieDetail!.id));
                                  } else {
                                    BlocProvider.of<MovieDetailsBloc>(context).add(
                                        AddFavoriteMoviesEvent(MovieModel(
                                            id: state.movieDetail!.id,
                                            title: state.movieDetail!.title,
                                            backdropPath:
                                                state.movieDetail!.backdropPath,
                                            overview:
                                                state.movieDetail!.overview,
                                            releaseDate:
                                                state.movieDetail!.releaseDate,
                                            voteAverage:
                                                state.movieDetail!.voteAverage,
                                            genreIds: [])));
                                  }
                                  // context.read<MovieDetailsBloc>().add(IsFavoriteMovieEvent(state.movieDetail!.id));
                                  // context.read<MovieDetailsBloc>();
                                  //     .listen((newState) {
                                  //   print("is favorite ${newState.isFavorite}");
                                  // });
                                  // print("is favorite ${state.isFavorite}");
                                  // // butFav = !butFav;
                                  // // buttonColor = Colors.red;
                                },
                                color: buttonColor,
                                icon: Icon(Icons.favorite),
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
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  state.movieDetail!.releaseDate.split('-')[0],
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
                                    (state.movieDetail!.voteAverage / 2)
                                        .toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '(${state.movieDetail!.voteAverage})',
                                    style: const TextStyle(
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                _showDuration(state.movieDetail!.runtime),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            state.movieDetail!.overview,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Genres: ${_showGenres(state.movieDetail!.genres)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
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
                recommendation.length != 0
                    ? SliverPadding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                        sliver: _showRecommendations(recommendation),
                      )
                    : SizedBox(),
              ],
            );
          case RequestState.error:
            return Center(child: Text(state.movieDetailsMessage));
        }
      },
    );
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MovieDetailScreen(
                    id: recommendation[index].id,
                  ),
                ),
              );
            },
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: CachedNetworkImage(
                    imageUrl: ApiConstance.imageUrl(
                        recommendation[index].backdropPath!),
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
