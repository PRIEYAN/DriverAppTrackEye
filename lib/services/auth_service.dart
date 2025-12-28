import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../core/auth_storage.dart';
import '../models/models.dart';

class AuthService {
  final String baseUrl = AppConstants.baseUrl;

  Future<Driver> login(String emailOrUsername, String password) async {
    final requestBody = json.encode({
      'email': emailOrUsername,
      'password': password,
    });

    final response = await http.post(
      Uri.parse('$baseUrl/driver/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      
      // Handle wrapped response
      final data = responseData is Map && responseData.containsKey('data')
          ? responseData['data']
          : responseData;
      
      // Extract token and driver info
      if (data is Map) {
        final token = data['access_token'] as String?;
        final driverData = data['driver'] as Map<String, dynamic>?;
        
        if (token != null) {
          await AuthStorage.saveToken(token);
        }
        
        if (driverData != null) {
          final driver = Driver.fromJson(driverData);
          await AuthStorage.saveDriver(json.encode(driverData));
          return driver;
        }
      }
      
      throw Exception('Invalid response format');
    } else {
      final errorBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};
      final errorMessage = errorBody['reason'] ??
          errorBody['detail'] ??
          errorBody['message'] ??
          'Login failed';
      throw Exception(errorMessage);
    }
  }

  Future<Driver> register(String username, String email, String password) async {
    final requestBody = json.encode({
      'username': username,
      'email': email,
      'password': password,
    });

    final response = await http.post(
      Uri.parse('$baseUrl/driver/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseData = json.decode(response.body);
      
      // Handle wrapped response
      final data = responseData is Map && responseData.containsKey('data')
          ? responseData['data']
          : responseData;
      
      // Extract token and driver info
      if (data is Map) {
        final token = data['access_token'] as String?;
        final driverData = data['driver'] as Map<String, dynamic>?;
        
        if (token != null) {
          await AuthStorage.saveToken(token);
        }
        
        if (driverData != null) {
          final driver = Driver.fromJson(driverData);
          await AuthStorage.saveDriver(json.encode(driverData));
          return driver;
        }
      }
      
      throw Exception('Invalid response format');
    } else {
      final errorBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};
      final errorMessage = errorBody['reason'] ??
          errorBody['detail'] ??
          errorBody['message'] ??
          'Registration failed';
      throw Exception(errorMessage);
    }
  }

  Future<void> logout() async {
    await AuthStorage.clear();
  }

  Future<bool> isAuthenticated() async {
    return await AuthStorage.hasToken();
  }
}

