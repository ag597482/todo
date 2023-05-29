import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  Future<int> getIntVal(String dbKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? value = prefs.getInt(dbKey);
    return value ?? 0;
  }

  void updateIntVal(String dbKey, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(dbKey, value);
  }

  Future<String> getStringVal(String dbKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(dbKey);
    return value ?? "";
  }

  void updateStringVal(String dbKey, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(dbKey, value);
  }
}
