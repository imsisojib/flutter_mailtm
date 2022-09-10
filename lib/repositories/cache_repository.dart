import 'package:shared_preferences/shared_preferences.dart';

class CacheRepository{
  final SharedPreferences sharedPreferences;
  CacheRepository({required this.sharedPreferences});

  Future<void> saveToken(String token) async {
    await sharedPreferences.setString("token", token);
  }

  Future<String?> fetchToken() async {
    return sharedPreferences.getString("token");
  }

  Future<void> saveUserName(String userName) async {
    await sharedPreferences.setString("user_name", userName);
  }

  Future<String?> fetchUserName() async {
    return sharedPreferences.getString("user_name");
  }

  Future<void> saveMailList(String response) async {
    await sharedPreferences.setString("mail_list", response);
  }

  Future<String?> fetchMailList() async {
    return sharedPreferences.getString("mail_list");
  }

  Future<void> clearCache() async {
    await sharedPreferences.setString("token", "");
    await sharedPreferences.setString("mail_list", "");
    await sharedPreferences.setString("user_name", "");
  }

}