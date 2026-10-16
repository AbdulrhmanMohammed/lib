import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {

  final String baseUrl = 'https://24fvn1bb-7068.inc1.devtunnels.ms/api/Users';

  // LOGIN
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        "success": true,
        "message": "Login successful",
        "data": data
      };
    } else {
      return {
        "success": false,
        "message": data["message"] ?? "Invalid username or password"
      };
    }
  }

  // REGISTER
  Future<Map<String, dynamic>> register(
      String name,
      String email,
      String username,
      String password
      ) async {

    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        "success": true,
        "message": "Account created successfully"
      };
    } else {
      return {
        "success": false,
        "message": data["message"] ?? "Registration failed"
      };
    }
  }
}
