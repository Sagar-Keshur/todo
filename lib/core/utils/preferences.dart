import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _shared;

  static final Preferences _instance = Preferences();
  static Preferences get instance => _instance;

  ///string messages
  final String _isLogged = 'isLogged';
  final String _uid = 'uid';

  ///init
  static Future<void> init() async {
    _shared = await SharedPreferences.getInstance();
  }

  bool get isLogged => _shared?.getBool(_isLogged) ?? false;

  set isLogged(bool value) => _shared?.setBool(_isLogged, value);

  String get uid => _shared?.getString(_uid) ?? '';

  set uid(String value) => _shared?.setString(_uid, value);

  Future<void> logOut() async {
    await _shared?.clear();
  }
}
