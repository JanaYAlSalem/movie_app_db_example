import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_db_example/core/utils/theme/color.dart';
import 'package:movie_app_db_example/movies/presentation/home_screen/cubit/app_movies_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppMoviesCubit, AppMoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
              child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(children: [
              ListTile(
                title: const Text("Dark Mode"),
                leading: const Icon(Icons.dark_mode_outlined),
                trailing: Switch(
                  // activeColor: AppColors.gray30,
                  //   activeTrackColor: AppColors.green30,
                    value: AppMoviesCubit.get(context).isDark,
                    onChanged: (value) {
                      AppMoviesCubit.get(context).changeAppMode();
                }),
                onTap: () {},
              ),
              ListTile(
                title: const Text("Language"),
                leading: const Icon(Icons.language_outlined),
                trailing: Switch(value: false, onChanged: (value) {}),
                onTap: () {},
              )
            ]),
          ));
        });
  }
}
