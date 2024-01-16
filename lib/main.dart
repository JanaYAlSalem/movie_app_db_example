import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/utils/bloc_observer.dart';
import 'package:movie_app_db_example/core/utils/theme/dark_theme.dart';
import 'package:movie_app_db_example/core/utils/theme/light_theme.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/home_screen.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => servicesLocator<AppMoviesCubit>()
          ..getNowPlayingMovies()
          ..getPopularMovies()
          ..getTopRatedMovies()
          ..getMode(),
        child: BlocBuilder<AppMoviesCubit, AppMoviesStates>(
            builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            // themeMode: ThemeMode.dark,
            themeMode: AppMoviesCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const HomeScreen(),
          );
        })
  );
  }
}
