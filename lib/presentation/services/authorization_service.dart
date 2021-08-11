import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationService {
  Future<bool> isAuthorized() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if (prefs.getInt('AccountId') == null || prefs.getInt('AccountId') == 0) {
      return false;
    } else {
      return true;
    }
  }
}
