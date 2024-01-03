import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/utils/bloc_observer.dart';
import 'package:movie_app_db_example/core/utils/theme/color.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/home_screen.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => servicesLocator<AppMoviesCubit>(),
        child: BlocConsumer<AppMoviesCubit, AppMoviesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.white,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  backgroundColor: AppColors.white,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: AppColors.blue40,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.blue40,
                  unselectedItemColor: AppColors.gray10,
                  elevation: 20.0,
                  backgroundColor: AppColors.green30,
                ),
                textTheme: TextTheme(
                  bodyText1: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                    color: AppColors.blue40,
                  ),
                ),
                listTileTheme: const ListTileThemeData(
                    // TODO: The properties you want to set.
                    ),
              ),

              darkTheme: ThemeData(
                scaffoldBackgroundColor: AppColors.blue40,
                appBarTheme: const AppBarTheme(
                  titleSpacing: 20.0,
                  // backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: AppColors.blue40,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: AppColors.blue40,
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: AppColors.green30,
                  unselectedItemColor: Colors.grey,
                  elevation: 20.0,
                  backgroundColor: AppColors.blue40,
                ),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                listTileTheme: const ListTileThemeData(
                    // TODO: The properties you want to set.
                    ),
              ),
              // themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              themeMode: AppMoviesCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const HomeScreen(),
            );
          },
        ));
  }
}
