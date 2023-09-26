import 'dart:convert';

import 'package:coop/src/services/cache_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import '../../models/protest_event.dart';

part 'protest_events_api_handler.dart';

const protestEventsProvider = CacheBuilder<List<ProtestEvent>>(
  cacheKey: "protest_events_provider",
  cacheTTL: Duration(minutes: 30),
  builder: _ProtestEventsApiHandler.get,
  toJson: _encodeProtestEvents,
  fromJson: _decodeProtestEvents,
);

String _encodeProtestEvents(List<ProtestEvent> protestEvents) {
  final mappedProtestEvents =
      protestEvents.map((protestEvent) => protestEvent.toMap()).toList();

  return json.encode(mappedProtestEvents);
}

List<ProtestEvent> _decodeProtestEvents(String jsonProtestEvents) {
  final List<dynamic> mappedProtestEventsList = json.decode(jsonProtestEvents);
  final List<ProtestEvent> protestEvents = mappedProtestEventsList
      .map((protestEvent) => ProtestEvent.fromMap(protestEvent))
      .toList();
  return protestEvents;
}
