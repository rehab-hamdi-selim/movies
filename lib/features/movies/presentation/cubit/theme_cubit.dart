import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences prefs;
  static const _kIsDark = 'isDarkMode';

  ThemeCubit({required this.prefs})
    : super(ThemeState(isDark: prefs.getBool(_kIsDark) ?? false));

  Future<void> toggleTheme() async {
    final newVal = !state.isDark;
    await prefs.setBool(_kIsDark, newVal);
    emit(ThemeState(isDark: newVal));
  }

  // optional: explicit setter
  Future<void> setDark(bool isDark) async {
    await prefs.setBool(_kIsDark, isDark);
    emit(ThemeState(isDark: isDark));
  }
}
