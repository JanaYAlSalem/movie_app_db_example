import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/network/api_constance.dart';
import 'package:movie_app_db_example/movies/domain/entities/movie.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/movie_details/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMoviesCubit, AppMoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            key: const Key('movieScrollView'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Now Playing",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                _buildListOfItemWidget(
                    context, AppMoviesCubit.get(context).nowPlayingMoviesList),
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular",
                        style: Theme.of(context).textTheme.bodyText1,
                ),
                    ],
                  ),
                ),
                _buildListOfItemWidget(context,
                    AppMoviesCubit.get(context).popularMoviesMoviesList),
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    16.0,
                    24.0,
                    16.0,
                    8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                _buildListOfItemWidget(
                    context, AppMoviesCubit.get(context).topRatedMoviesList),
                const SizedBox(height: 50.0),
              ],
            ),
          );
        });
  }

  Widget _buildListOfItemWidget(
      BuildContext context, List<Movie> listOfMovies) {
    return FadeIn(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        height: 170.0,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: listOfMovies.length,
          itemBuilder: (context, index) {
            return _buildItemCardWidget(
              listOfMovies[index],
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => MovieDetailScreen(movie:listOfMovies[index]
                    ),
                  ),
                );
              },
              context
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemCardWidget(Movie movie, Function()? onTap, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: Column(
            children: [
              CachedNetworkImage(
                width: 120.0,
                fit: BoxFit.cover,
                imageUrl:ApiConstance.imageUrl(movie.backdropPath),
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // Text(movie.title, style: Theme.of(context).textTheme.bodyText1,)
            ],
          ),
        ),
      ),
    );
  }
}
