import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../utils/shared_preferences_service.dart';
import '../utils/constants.dart';

class ApiService {
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.apiUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> getUserDetails(String token) async {
    final response = await http.post(
      Uri.parse('${Constants.apiUrl}/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> fetchProtectedData() async {
    // Retrieve the token
    final String? token = await _prefsService.getToken();

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse(
        '${Constants.apiUrl}/protected',
      ), // Replace with your protected endpoint
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Handle the response
      print('Protected data: ${response.body}');
    } else {
      throw Exception('Failed to fetch protected data');
    }
  }
}
