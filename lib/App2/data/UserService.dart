
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connection.dart';

class UserService {

  Future<Map<String, dynamic>?> register(
      String name,
      String email,
      String username,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse(ConnectionString.Register),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)
      as Map<String, dynamic>;
    }
    else if (response.statusCode == 409) {
      return null;
    }
    else {
      throw Exception(
        'Registration failed',
      );
    }
  }









  Future<Map<String, dynamic>?> login(
      String username,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse(ConnectionString.login),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 401) {
      return null;
    } else {
      throw Exception('Failed to login');
    }
  }
}