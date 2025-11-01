import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';

abstract class MoviesLocalDataSource {
  Future<void> cacheMoviesPage(int page, List<MovieModel> movies);
  Future<List<MovieModel>?> getCachedMovies();
  Future<void> addErrorLog(String error);
  Future<List<String>> getErrorLogs();
  Future<void> saveTheme(bool isDark);
  Future<bool> getSavedTheme();
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final SharedPreferences prefs;
  MoviesLocalDataSourceImpl(this.prefs);

  static const String cachedMoviesKey = 'CACHED_MOVIES';
  static const String errorLogsKey = 'ERROR_LOGS';
  static const String themeKey = 'isDarkMode';

  @override
  Future<void> cacheMoviesPage(int page, List<MovieModel> movies) async {
    // store as whole list replacement (simple approach)
    final existing = prefs.getString(cachedMoviesKey);
    List<dynamic> merged = [];
    if (existing != null) {
      merged = json.decode(existing) as List<dynamic>;
    }
    // append new (avoid duplicates by id)
    final ids = merged.map((e) => e['id'] as int).toSet();
    for (var m in movies) {
      if (!ids.contains(m.id)) merged.add(m.toJson());
    }
    await prefs.setString(cachedMoviesKey, json.encode(merged));
  }

  @override
  Future<List<MovieModel>?> getCachedMovies() async {
    final raw = prefs.getString(cachedMoviesKey);
    if (raw == null) return null;
    final list = json.decode(raw) as List<dynamic>;
    return list
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addErrorLog(String error) async {
    final list = prefs.getStringList(errorLogsKey) ?? [];
    list.add('${DateTime.now().toIso8601String()} - $error');
    // keep last 50
    final trimmed = list.length > 50 ? list.sublist(list.length - 50) : list;
    await prefs.setStringList(errorLogsKey, trimmed);
  }

  @override
  Future<List<String>> getErrorLogs() async {
    return prefs.getStringList(errorLogsKey) ?? [];
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    await prefs.setBool(themeKey, isDark);
  }

  @override
  Future<bool> getSavedTheme() async {
    return prefs.getBool(themeKey) ?? true;
  }
}
