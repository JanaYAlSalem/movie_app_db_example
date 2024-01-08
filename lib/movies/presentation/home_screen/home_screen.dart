import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';
import 'package:movie_app_db_example/core/utils/theme/color.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => servicesLocator<AppMoviesCubit>()
        ..getNowPlayingMovies()
        ..getPopularMovies()
        ..getTopRatedMovies()
        ..getMode(),
      // create: (context) => AppMoviesCubit()..getNowPlayingMovies,
      child: BlocConsumer<AppMoviesCubit, AppMoviesStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    semanticsLabel: 'My SVG Image',
                    height: 20,
                    width: 20,
                    color: AppColors.green30,
                  ),
                ],
              ),
            ),
            body: AppMoviesCubit.get(context).appScreens[
                AppMoviesCubit.get(context).bottomNavigationBarIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex:
                    AppMoviesCubit.get(context).bottomNavigationBarIndex,
                onTap: (index) {
                  AppMoviesCubit.get(context).changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: "Favorite"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ]),
          );
        },
      ),
    );
  }
}
