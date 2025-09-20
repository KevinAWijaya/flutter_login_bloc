import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_pos_test/core/constants/sp.dart';

class SessionRepository {
  Future<void> saveCredentials(String username, String password, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefConst.keyUsername, username);
    await prefs.setString(PrefConst.keyPassword, password);
    await prefs.setBool(PrefConst.keyRememberMe, rememberMe);
  }

  Future<(String?, String?, bool)> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(PrefConst.keyUsername);
    final password = prefs.getString(PrefConst.keyPassword);
    final rememberMe = prefs.getBool(PrefConst.keyRememberMe) ?? false;
    return (username, password, rememberMe);
  }

  Future<void> clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
