import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProtestEvent {
  static ProtestEvent parseFromApi(Map<String, dynamic> apiEvent) {
    ProtestEvent protestEvent = ProtestEvent.pure();
    try {
      protestEvent = protestEvent.copyWith(
        name: apiEvent['eventName'] as String,
        type: apiEvent['eventType'] as String,
        description: apiEvent['eventDescription'] as String,
        date: _parseDateFromApi(
          dateString: apiEvent['eventDateString'],
          timeString: apiEvent['eventStartTime'],
        ),
        location: LatLng.fromJson([
          double.parse(apiEvent['latitude'].toString()),
          double.parse(apiEvent['longitude'].toString())
        ]),
        address: apiEvent['eventAddress'] as String,
        city: apiEvent['eventCity'] as String,
        orgName: apiEvent['orgName'] as String,
      );
    } catch (e) {
      if (kDebugMode) {
        print("FAILED CONVERTING PROTEST EVENT FROM API $e");
      }
    }
    return protestEvent;
  }

  final String name;
  final String type;
  final String description;
  final DateTime date;
  final LatLng location;
  final String address;
  final String city;
  final String orgName;
  ProtestEvent({
    required this.name,
    required this.type,
    required this.description,
    required this.date,
    required this.location,
    required this.address,
    required this.city,
    required this.orgName,
  });

  ProtestEvent.pure()
      : name = "name",
        type = "type",
        description = "description",
        date = DateTime.utc(0),
        location = const LatLng(0, 0),
        address = "address",
        city = "city",
        orgName = "orgName";

  ProtestEvent copyWith({
    String? name,
    String? type,
    String? description,
    DateTime? date,
    LatLng? location,
    String? address,
    String? city,
    String? orgName,
  }) {
    return ProtestEvent(
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
      location: location ?? this.location,
      address: address ?? this.address,
      city: city ?? this.city,
      orgName: orgName ?? this.orgName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'location': [location.latitude, location.longitude],
      'address': address,
      'city': city,
      'orgName': orgName,
    };
  }

  factory ProtestEvent.fromMap(Map<String, dynamic> map) {
    ProtestEvent protestEvent = ProtestEvent.pure();
    try {
      protestEvent = protestEvent.copyWith(
        name: map['name'] as String,
        type: map['type'] as String,
        description: map['description'] as String,
        date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
        location: LatLng.fromJson(map['location'] as List<int>),
        address: map['address'] as String,
        city: map['city'] as String,
        orgName: map['orgName'] as String,
      );
    } catch (e) {
      if (kDebugMode) {
        print("FAILED CONVERTING PROTEST EVENT FROM MAP $e");
      }
    }
    return protestEvent;
  }

  String toJson() => json.encode(toMap());

  factory ProtestEvent.fromJson(String source) =>
      ProtestEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProtestEvent(name: $name, type: $type, description: $description, date: $date, location: $location, address: $address, city: $city, orgName: $orgName)';
  }
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
