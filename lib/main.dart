import 'package:flutter/material.dart';
import 'package:movie_app_db_example/movies/presentation/movies/screens/movies_screen.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';


void main() async {
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const MoviesScreen(),
    );
  }
}