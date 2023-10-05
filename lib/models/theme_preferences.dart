import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  static const themeMode = 'MODE';
  static const dark = "DARK";
  static const light = "LIGHT";

  setModeTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(themeMode, theme);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(themeMode) ?? light;
  }
}
