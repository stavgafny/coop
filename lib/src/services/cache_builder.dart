import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CacheSegment {
  final String jsonData;
  final DateTime expirationDate;

  const _CacheSegment({required this.jsonData, required this.expirationDate});

  bool get expired => DateTime.now().isAfter(expirationDate);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jsonData': jsonData,
      'expirationDate': expirationDate.millisecondsSinceEpoch,
    };
  }

  factory _CacheSegment.fromMap(Map<String, dynamic> map) {
    return _CacheSegment(
      jsonData: map['jsonData'] as dynamic,
      expirationDate:
          DateTime.fromMillisecondsSinceEpoch(map['expirationDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory _CacheSegment.fromJson(String source) =>
      _CacheSegment.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CacheBuilder<T> {
  static const String _cacheStoreName = "\$CacheBuilder@";

  static Future<bool> _storeSegment(String key, _CacheSegment segment) async {
    try {
      final instance = await SharedPreferences.getInstance();
      return instance.setString(key, segment.toJson());
    } catch (e) {
      return false;
    }
  }

  static Future<_CacheSegment?> _readSegment(String key) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final data = instance.getString(key);
      return data != null ? _CacheSegment.fromJson(data) : null;
    } catch (e) {
      return null;
    }
  }

  final String cacheKey;
  final Duration cacheTTL;
  final Future<T> Function() builder;
  final String Function(T data) toJson;
  final T Function(String source) fromJson;

  const CacheBuilder({
    required String cacheKey,
    required this.cacheTTL,
    required this.builder,
    required this.toJson,
    required this.fromJson,
  }) : cacheKey = "$_cacheStoreName$cacheKey";

  void _save(String jsonData) async {
    await _storeSegment(
      cacheKey,
      _CacheSegment(
        jsonData: jsonData,
        expirationDate: DateTime.now().add(cacheTTL),
      ),
    );
  }

  Future<T> getData() async {
    final cacheSegment = await _readSegment(cacheKey);
    if (cacheSegment != null && !cacheSegment.expired) {
      if (kDebugMode) {
        print("LOADING FROM CACHE");
      }
      try {
        return fromJson(cacheSegment.jsonData);
      } catch (e) {
        if (kDebugMode) {
          print("FAILED TO '$cacheKey' LOAD FROM CACHE $e");
        }
      }
    }
    final T newData = await builder();
    final jsonData = toJson(newData);
    _save(jsonData);
    if (kDebugMode) {
      print("BUILDING AND SAVING");
    }
    return newData;
  }
}
