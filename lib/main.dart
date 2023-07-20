import 'package:flutter/material.dart';
import './src/configs/app_config.dart';
import './src/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appConfig.init();
  runApp(const MainApp());
}
