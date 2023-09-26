import 'package:flutter/material.dart';
import './src/providers/protest_events_provider/protest_events_provider.dart';
import './src/configs/app_config.dart';
import './src/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appConfig.init();

  final protestEvents = await protestEventsProvider.getData();
  print("${protestEvents.length} protest events loaded");
  runApp(const MainApp());
}
