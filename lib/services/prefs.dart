import 'package:shared_preferences/shared_preferences.dart';

import '../helper/utils.dart';

import '../helper/enums/auth_status_enum.dart';

import '../models/user_account.dart';

class Prefs{

  ///Singleton instance of prefs class
  ///This class provides low level preferences methods
  static final _prefs = _$Prefs();

  ///Instance of Prefs Wrapper
  static final instance = Prefs._();

  Prefs._();

  ///Returns logged in user account
  Future<UserAccount> getAuthUserKey() async {
    String number = await _prefs.get(Utils.authUserKey);
    return number == null ? number : UserAccount(number);
  }

  ///Returns last authentication status
  Future<AuthStatus> getAuthStatusKey() async {
    String status = await _prefs.get(Utils.authStatusKey);
    if(status == null) return AuthStatus.LOGGED_OUT;
    return AuthStatus.values.firstWhere((authStatus) {
      return authStatus.toString() == status;
    });
  }

  ///Sets the authentication key to this value
  setAuthUserKey(String value) async {
    return await _prefs.set(Utils.authUserKey, value);
  }

  ///Sets the authentication status to this value
  setAuthStatusKey(AuthStatus authStatus) async {
    return await _prefs.set(Utils.authStatusKey, authStatus.toString());
  }

  ///Resets the authentication
  resetAuth() async {
    await _prefs.clear();
  }
}

///Internal class for shared preferences methods
class _$Prefs{
  ///Instance of shared preferences
  static final _sharedPrefs = SharedPreferences.getInstance();

  ///Loads value for the key from preferences
  get(String key) async {
    final pref = await _sharedPrefs;
    return pref.getString(key);
  }

  ///Sets the value for the key to preferences
  set(String key, String value) async {
    final pref = await _sharedPrefs;
    return pref.setString(key,value);
  }

  ///Resets preferences
  clear() async {
    final pref = await _sharedPrefs;
    pref.clear();
  }
}
