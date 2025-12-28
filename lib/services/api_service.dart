import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../core/constants.dart';
import '../core/auth_storage.dart';

class ApiService {
  final String baseUrl = AppConstants.baseUrl;
  
  Future<Map<String, String>> _getHeaders() async {
    final token = await AuthStorage.getToken();
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<Driver> getMyProfile() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/driver/my-profile'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Handle both wrapped and unwrapped responses
      final data = responseData is Map && responseData.containsKey('data')
          ? responseData['data']
          : responseData;
      
      if (data == null) {
        throw Exception('No profile data received');
      }
      
      return Driver.fromJson(data as Map<String, dynamic>);
    } else {
      final errorBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};
      if (response.statusCode == 401) {
        // Clear token if unauthorized
        await AuthStorage.clear();
        throw Exception('Unauthorized: Please login again');
      }
      
      final errorMessage = errorBody['reason'] ??
          errorBody['detail'] ??
          errorBody['message'] ??
          'Failed to get profile';
      throw Exception(errorMessage);
    }
  }

  Future<Shipment?> getMyShipments() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/driver/my-shipments'),
      headers: headers,
    );
    
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      // Handle both wrapped and unwrapped responses
      final data = responseData is Map && responseData.containsKey('data')
          ? responseData['data']
          : responseData;
      
      if (data == null) {
        return null; // No shipment assigned
      }
      
      return Shipment.fromJson(data as Map<String, dynamic>);
    } else {
      final errorBody = response.body.isNotEmpty
          ? json.decode(response.body)
          : <String, dynamic>{};
      if (response.statusCode == 401) {
        // Clear token if unauthorized
        await AuthStorage.clear();
        throw Exception('Unauthorized: Please login again');
      }
      
      final errorMessage = errorBody['reason'] ??
          errorBody['detail'] ??
          errorBody['message'] ??
          'Failed to get shipments';
      throw Exception(errorMessage);
    }
  }
}

