import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<int> getIntVal(String dbKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? value = prefs.getInt(dbKey);
    return value ?? 10;
  }

  void updateIntVal(String dbKey, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(dbKey, value);
  }

  Future<String> getStringVal(String dbKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(dbKey);
    return value ?? "0000";
  }

  void updateStringVal(String dbKey, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(dbKey, value);
  }

  Future<List<String>> getStringListVal(String dbKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? value = prefs.getStringList(dbKey);
    return value ?? [];
  }

  void updateStringListVal(String dbKey, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(dbKey, value);
  }
}
