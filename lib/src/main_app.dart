import 'package:flutter/material.dart';
import './constants/theme/app_theme.dart';
import './features/home/home_view.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coop',
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeView(),
    );
  }
}
