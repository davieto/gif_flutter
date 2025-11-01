import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PreferencesState {
  final bool isDark;
  final String rating;
  final String language;
  final String size;
  final bool autoplay;
  final String primaryColor;

  const PreferencesState({
    this.isDark = false,
    this.rating = 'g',
    this.language = 'pt',
    this.size = 'medium',
    this.autoplay = true,
    this.primaryColor = 'pink',
  });

  PreferencesState copyWith({
    bool? isDark,
    String? rating,
    String? language,
    String? size,
    bool? autoplay,
    String? primaryColor,
  }) {
    return PreferencesState(
      isDark: isDark ?? this.isDark,
      rating: rating ?? this.rating,
      language: language ?? this.language,
      size: size ?? this.size,
      autoplay: autoplay ?? this.autoplay,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

class PreferencesNotifier extends StateNotifier<PreferencesState> {
  PreferencesNotifier() : super(const PreferencesState()) {
    _load();
  }

  Future<void> _load() async {
    final box = Hive.box('preferences');
    state = PreferencesState(
      isDark: box.get('darkMode', defaultValue: false),
      rating: box.get('rating', defaultValue: 'g'),
      language: box.get('language', defaultValue: 'pt'),
      size: box.get('size', defaultValue: 'medium'),
      autoplay: box.get('autoplay', defaultValue: true),
      primaryColor: box.get('primaryColor', defaultValue: 'pink'),
    );
  }

  Future<void> _save(String key, dynamic value) async {
    final box = Hive.box('preferences');
    await box.put(key, value);
  }

  Future<void> setTheme(bool dark) async {
    await _save('darkMode', dark);
    state = state.copyWith(isDark: dark);
  }

  Future<void> setGifSize(String val) async {
    await _save('size', val);
    state = state.copyWith(size: val);
  }

  Future<void> setRating(String val) async {
    await _save('rating', val);
    state = state.copyWith(rating: val);
  }

  Future<void> setLanguage(String val) async {
    await _save('language', val);
    state = state.copyWith(language: val);
  }

  Future<void> setAutoplay(bool val) async {
    await _save('autoplay', val);
    state = state.copyWith(autoplay: val);
  }

  Future<void> setColor(String val) async {
    await _save('primaryColor', val);
    state = state.copyWith(primaryColor: val);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, PreferencesState>(
  (ref) => PreferencesNotifier(),
);