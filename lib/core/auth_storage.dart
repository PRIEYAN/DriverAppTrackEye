import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _tokenKey = 'driver_token';
  static const String _driverKey = 'driver_data';

  // Save JWT token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get JWT token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Save driver data
  static Future<void> saveDriver(String driverJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_driverKey, driverJson);
  }

  // Get driver data
  static Future<String?> getDriver() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_driverKey);
  }

  // Clear all auth data
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_driverKey);
  }

  // Check if user is authenticated
  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

