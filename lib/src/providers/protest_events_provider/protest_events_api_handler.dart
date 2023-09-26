part of './protest_events_provider.dart';

final _dio = Dio();
final eventsUrl = FlutterConfig.get("PROTEST_EVENTS_URL");

class _ProtestEventsApiHandler {
  static Future<List<dynamic>> _fetchProtestEvents() async {
    final response = await _dio.get(eventsUrl);
    return response.data;
  }

  static List<ProtestEvent> _asProtestEvents(List<dynamic> protestEventsData) {
    return protestEventsData
        .map((protestEventData) => _parseFromApi(protestEventData))
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

ProtestEvent _parseFromApi(dynamic protestEventData) {
  final Map<String, dynamic> eventMap = {
    'name': protestEventData['eventName'] as String,
    'type': protestEventData['eventType'] as String,
    'description': protestEventData['eventDescription'] as String?,
    'date': _parseDateFromApi(
      dateString: protestEventData['eventDateString'],
      timeString: protestEventData['eventStartTime'],
    ).millisecondsSinceEpoch,
    'location': [
      double.tryParse(protestEventData['latitude'].toString()),
      double.tryParse(protestEventData['longitude'].toString()),
    ],
    'address': protestEventData['eventAddress'] as String?,
    'city': protestEventData['eventCity'] as String,
    'orgName': protestEventData['orgName'] as String,
  };

  return ProtestEvent.fromMap(eventMap);
}

DateTime _parseDateFromApi({
  required String dateString,
  required String timeString,
}) {
  final int year = int.parse(dateString.substring(4));
  final int month = int.parse(dateString.substring(2, 4));
  final int day = int.parse(dateString.substring(0, 2));
  final int hour = int.parse(dateString.substring(0, 2));
  final int minute = int.parse(dateString.substring(3));

  return DateTime(year, month, day, hour, minute);
}
