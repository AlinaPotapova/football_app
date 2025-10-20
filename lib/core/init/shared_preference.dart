import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  SharedPreferences? _preferences;
  static SharedPrefsManager? _instance;

  static SharedPrefsManager get instance =>
      _instance ??= SharedPrefsManager._init();

  SharedPrefsManager._init();

  // Initialize SharedPreferences once
  static Future preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences?.clear();
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future<void> setBoolValue(String key, {required bool value}) async {
    await _preferences?.setBool(key, value);
  }

  List<String> getStringListValue(String key) =>
      _preferences?.getStringList(key) ?? [];
  String getStringValue(String key) => _preferences?.getString(key) ?? '';

  bool getBoolValue(String key) => _preferences?.getBool(key) ?? true;

  saveGameData(
    String player1Name,
    int player1Score,
    String player2Name,
    int player2Score,
    String winner,
  ) async {
    final games = _preferences?.getStringList('matches_data') ?? <String>[];
    final newGame =
        '$player1Name,$player1Score,$player2Name,$player2Score,$winner';
    games.add(newGame);
    await _preferences?.setStringList('matches_data', games);
  }
}
