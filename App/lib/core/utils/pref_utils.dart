import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class PrefUtils {
  factory PrefUtils() {
    return _instance;
  }

  PrefUtils._internal();

  static SharedPreferences? _sharedPreferences;

  static final PrefUtils _instance = PrefUtils._internal();

  /// Initializes the [SharedPreferences] instance and sets it to the
  /// [_sharedPreferences] variable.
  ///
  /// This method should be called at the beginning of the application startup to
  /// ensure that [SharedPreferences] is ready to use.
  ///
  /// Throws an exception if there is an error while initializing the instance.
  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    debugPrint('SharedPreference Initialized');
  }

  /// Clears all data from the SharedPreferences instance.
  void clearPreferencesData() async {
    _sharedPreferences!.clear();
  }

  Future<void> setId(String value) {
    return _sharedPreferences!.setString('id', value);
  }

  String getId() {
    try {
      return _sharedPreferences!.getString('id') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setStation(String value) {
    return _sharedPreferences!.setString('station', value);
  }

  String getStation() {
    try {
      return _sharedPreferences!.getString('station') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setMobile(String value) {
    return _sharedPreferences!.setString('mobile', value);
  }

  String getMobile() {
    try {
      return _sharedPreferences!.getString('mobile') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setName(String value) {
    return _sharedPreferences!.setString('name', value);
  }

  String getName() {
    try {
      return _sharedPreferences!.getString('name') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setNotificationStatus(bool value) {
    return _sharedPreferences!.setBool('notificationStatus', value);
  }

  bool getNotificationStatus() {
    try {
      return _sharedPreferences!.getBool('notificationStatus') ?? true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<void> setNotificationList(List<String> value) {
    return _sharedPreferences!.setStringList('notificationList', value);
  }

  List<String> getNotificationList() {
    try {
      return _sharedPreferences!.getStringList('notificationList') ?? [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> setDuty(String value) {
    return _sharedPreferences!.setString('duty', value);
  }

  String getDuty() {
    try {
      return _sharedPreferences!.getString('duty') ?? '';
    } catch (e) {
      return '';
    }
  }

  Future<void> setLanguage(String value) {
    return _sharedPreferences!.setString('language', value);
  }

  String getLanguage() {
    try {
      return _sharedPreferences!.getString('language') ?? 'en';
    } catch (e) {
      return '';
    }
  }
}
