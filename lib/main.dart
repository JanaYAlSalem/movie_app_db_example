import 'dart:io';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:movie_app_db_example/movies/presentation/screens/movies_screen.dart';
import 'package:movie_app_db_example/core/services/services_locator.dart';
import 'package:movie_app_db_example/movies/data/datasource/movie_local_data_source.dart';
import 'package:movie_app_db_example/movies/data/models/movies_model_db.dart';
import 'package:movie_app_db_example/movies/presentation/screens/movies_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const MoviesScreen(),
    );
  }
}