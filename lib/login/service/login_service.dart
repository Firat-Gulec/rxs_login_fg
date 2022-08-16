import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<void> loginUser(String name, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', name);
    prefs.setString('password', password);
  }
}
