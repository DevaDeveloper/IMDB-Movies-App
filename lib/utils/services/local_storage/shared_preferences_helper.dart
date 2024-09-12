import 'package:imdb_movies_app/consts/local_storage/shared_preferences_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesConsts.SHARED_PREFERENCES_TOKEN_KEY, token);
  }

  static void clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConsts.SHARED_PREFERENCES_TOKEN_KEY);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesConsts.SHARED_PREFERENCES_TOKEN_KEY);
  }

  static void setRefreshToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesConsts.SHARED_PREFERENCES_REFRESH_TOKEN_KEY, token);
  }

  static void clearRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConsts.SHARED_PREFERENCES_REFRESH_TOKEN_KEY);
  }

  static Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesConsts.SHARED_PREFERENCES_REFRESH_TOKEN_KEY);
  }

  static void clearUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConsts.SHARED_PREFERENCES_USER_ID_KEY);
  }

  static void setLanguageCode(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesConsts.SHARED_PREFERENCES_LANGUAGE_KEY, languageCode);
  }

  static Future<String> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesConsts.SHARED_PREFERENCES_LANGUAGE_KEY) ?? 'en';
  }

  static void setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesConsts.SHARED_PREFERENCES_APP_THEME_KEY, theme);
  }

  static Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesConsts.SHARED_PREFERENCES_APP_THEME_KEY) ?? SharedPreferencesConsts.LIGHT_THEME;
  }

  static void setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesConsts.SHARED_PREFERENCES_USER_ID_KEY, userId);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesConsts.SHARED_PREFERENCES_USER_ID_KEY) ?? '';
  }

  static void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConsts.SHARED_PREFERENCES_USER_ID_KEY);
    await prefs.remove(SharedPreferencesConsts.SHARED_PREFERENCES_TOKEN_KEY);
    await prefs.remove(SharedPreferencesConsts.SHARED_PREFERENCES_REFRESH_TOKEN_KEY);
  }
}
