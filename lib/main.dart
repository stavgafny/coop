import 'package:flutter/material.dart';
import './src/providers/protest_events_provider/protest_events_provider.dart';
import './src/configs/app_config.dart';
import './src/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appConfig.init();

  final protests = await ProtestEventsProvider.get();
  for (var element in protests) {
    print(element);
  }
  runApp(const MainApp());
}
