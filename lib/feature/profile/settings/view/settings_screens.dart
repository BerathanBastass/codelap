import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [headerText()]),
      ),
    );
  }

  Padding headerText() {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        "Theme",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
