import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalSource {
  // Obtain shared preferences.
  SharedPreferences? prefs;
  static const String _token = 'token';

  Future<void> _init() async {
    if (prefs != null) {
      return;
    }

    prefs = await SharedPreferences.getInstance();
  }

  Future<void> storeToken(String token) async{
    await _init();
    await prefs?.setString(_token, token);
  }

  Future<bool> isLogin() async {
    await _init();
    return prefs?.getString(_token)?.isNotEmpty == true;
  }

  Future<void> logout() async {
    await _init();
    await prefs?.remove(_token);
  }

}