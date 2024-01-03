import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: ListView(children: [
        ListTile(
          title: const Text("Dark Mode"),
          leading: const Icon(Icons.dark_mode_outlined),
          trailing: Switch(value: true, onChanged: (value) {}),
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
  }
}
