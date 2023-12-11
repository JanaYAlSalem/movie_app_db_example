import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';
import 'package:movie_app_db_example/movies/presentation/components/favorite_movies_component.dart';
import 'package:movie_app_db_example/movies/presentation/components/now_playing_component.dart';
import 'package:movie_app_db_example/movies/presentation/components/popular_component.dart';
import 'package:movie_app_db_example/movies/presentation/components/top_rated_component.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movies/movies_bloc.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movies/movies_event.dart';
import 'package:movie_app_db_example/movies/presentation/controller/movies/movies_state.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => servicesLocator<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent())
        ..add(GetFavoriteMoviesEvent()),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              key: const Key('movieScrollView'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NowPlayingComponent(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopularComponent(),
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
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const TopRatedComponent(),
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
                          "My Favorite",
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const FavoriteMovies(),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
