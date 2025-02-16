import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/constants/strings.dart';

class HiveStorageService {
  late final Box _box;

  HiveStorageService._();

  static final HiveStorageService _instance = HiveStorageService._();

  factory HiveStorageService() => _instance;

  static Future<HiveStorageService> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(UserModelAdapter());
    _instance._box = await Hive.openBox('app_data');
    return _instance;
  }

  Future<void> saveData(String key, dynamic data) async {
    await _box.put(key, data);
  }

  dynamic getData(String key) {
    return _box.get(key);
  }

  Future<void> deleteData(String key) async {
    await _box.delete(key);
  }

  Future<void> clearData() async {
    await _box.clear();
  }

  ThemeMode getThemeMode() {
    final theme = _box.get(themeMode);

    if (theme == null || theme == 'system') {
      return ThemeMode.system;
    } else if (theme == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  Future<void> saveThemeMode(ThemeMode theme) async {
    await _box.put(themeMode, theme.toString().split('.').last);
  }

  Future<void> savePreviousSearches(String searchKeyword) async {
    var searches = _box.get('previousSearches', defaultValue: <String>[]);

    // dont save if the search keyword already exists
    if (searches.contains(searchKeyword)) {
      return;
    }

    searches.add(searchKeyword);

    // save only the last 5 searches
    if (searches.length > 5) {
      searches.removeAt(0);
    }

    // reverse the list so that the latest search is at the top
    searches = searches.reversed.toList();

    await _box.put('previousSearches', searches);
  }

  List<String> getPreviousSearches() {
    final res = _box.get('previousSearches', defaultValue: []);

    return res.cast<String>();
  }
}
