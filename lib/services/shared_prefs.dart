import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
   Future<void> saveUserData(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    data.forEach((key, value) => prefs.setString(key, value));
  }

   Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'first_name': prefs.getString('first_name') ?? '',
      'last_name': prefs.getString('last_name') ?? '',
      'email': prefs.getString('email') ?? '',
      'job': prefs.getString('job') ?? '',
      'address': prefs.getString('address') ?? '',
      'gender': prefs.getString('gender') ?? '',
    };
  }

   Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}