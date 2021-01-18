import 'package:message_app/models/user_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/utils.dart';

import '../helper/enums/auth_status_enum.dart';

class _$Prefs{
  static final _sharedPrefs = SharedPreferences.getInstance();

  get(String key) async {
    final pref = await _sharedPrefs;
    return pref.getString(key);
  }

  set(String key, String value) async {
    final pref = await _sharedPrefs;
    return pref.setString(key,value);
  }

  clear() async {
    final pref = await _sharedPrefs;
    pref.clear();
  }
}

class Prefs{
  static final _prefs = _$Prefs();

  static final instance = Prefs._();

  Prefs._();

  Future<UserAccount> getAuthUserKey() async {
    String number = await _prefs.get(Utils.authUserKey);
    return number == null ? number : UserAccount(number);
  }

  Future<AuthStatus> getAuthStatusKey() async {
    String status = await _prefs.get(Utils.authStatusKey);
    if(status == null) return AuthStatus.LOGGED_OUT;
    return AuthStatus.values.firstWhere((authStatus) {
      return authStatus.toString() == status;
    });
  }

  setAuthUserKey(String value) async {
    return await _prefs.set(Utils.authUserKey, value);
  }

  setAuthStatusKey(AuthStatus authStatus) async {
    return await _prefs.set(Utils.authStatusKey, authStatus.toString());
  }

  resetAuth() async {
    await _prefs.clear();
  }
}