import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../../data/database/app_database.dart';

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>(
        (ref) => PreferencesNotifier());

class PreferencesState {
  final bool isDark;
  final String rating;
  final String language;
  final String size;
  final bool autoplay;

  const PreferencesState({
    this.isDark = false,
    this.rating = 'g',
    this.language = 'pt',
    this.size = 'medium',
    this.autoplay = true,
  });

  PreferencesState copyWith({
    bool? isDark,
    String? rating,
    String? language,
    String? size,
    bool? autoplay,
  }) {
    return PreferencesState(
      isDark: isDark ?? this.isDark,
      rating: rating ?? this.rating,
      language: language ?? this.language,
      size: size ?? this.size,
      autoplay: autoplay ?? this.autoplay,
    );
  }
}

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  PreferencesNotifier() : super(const PreferencesState()) {
    _load();
  }

  Future<void> _load() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query('preferences', limit: 1);
    if (result.isNotEmpty) {
      final row = result.first;
      state = state.copyWith(
        isDark: (row['darkMode'] as int? ?? 0) == 1,
        rating: row['rating'] as String? ?? 'g',
        language: row['language'] as String? ?? 'pt',
        size: row['size'] as String? ?? 'medium',
        autoplay: (row['autoplay'] as int? ?? 1) == 1,
      );
    } else {
      await db.insert('preferences', {
        'darkMode': 0,
        'rating': 'g',
        'language': 'pt',
        'size': 'medium',
        'autoplay': 1,
      });
    }
  }

  Future<void> _save(Map<String, dynamic> data) async {
    final db = await AppDatabase.instance.database;
    await db.update('preferences', data);
  }

  Future<void> setTheme(bool dark) async {
    await _save({'darkMode': dark ? 1 : 0});
    state = state.copyWith(isDark: dark);
  }

  Future<void> setGifSize(String val) async {
    await _save({'size': val});
    state = state.copyWith(size: val);
  }

  Future<void> setRating(String val) async {
    await _save({'rating': val});
    state = state.copyWith(rating: val);
  }

  Future<void> setLanguage(String val) async {
    await _save({'language': val});
    state = state.copyWith(language: val);
  }

  Future<void> setAutoplay(bool val) async {
    await _save({'autoplay': val ? 1 : 0});
    state = state.copyWith(autoplay: val);
  }
}