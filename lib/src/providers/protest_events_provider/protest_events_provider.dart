import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

import '../../models/protest_event.dart';

final _dio = Dio();
final eventsUrl = FlutterConfig.get("PROTEST_EVENTS_URL");

class ProtestEventsProvider {
  static Future<List<dynamic>> _fetchProtestEvents() async {
    final response = await _dio.get(eventsUrl);
    return response.data;
  }

  static List<ProtestEvent> _asProtestEvents(List<dynamic> protestEventsData) {
    return protestEventsData
        .map((protestEventData) => ProtestEvent.parseFromApi(protestEventData))
        .toList();
  }

  static Future<List<ProtestEvent>> get() async {
    try {
      final protestEventsData = await _fetchProtestEvents();
      final protestEvents = _asProtestEvents(protestEventsData);
      return protestEvents;
    } catch (e) {
      return [];
    }
  }
}
