import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('krm-token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('krm-token');
    return token;
  }
}
