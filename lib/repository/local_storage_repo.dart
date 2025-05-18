import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepo {
  static String cityKey = 'CityKey';

  static Future<void> saveLocalCity(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cityKey, value);
  }

  static Future<String> getLocalCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(cityKey) ?? '';
  }
}
