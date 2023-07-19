import 'package:flutter/material.dart';
import './src/main_app.dart';
import './src/constants/theme/app_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coop',
      theme: darkTheme,
      home: const MainApp(),
    );
  }
}
