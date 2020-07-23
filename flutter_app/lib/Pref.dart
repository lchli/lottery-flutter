import 'package:shared_preferences/shared_preferences.dart';

class Pref{
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();

}