import 'package:http/http.dart' as http;

import 'dart:convert';

class UserService {


  Future<Map<String, dynamic>?>  login(String username, String password) async {

    final response = await http.post(
      Uri.parse('https://5lcp61q9-7100.inc1.devtunnels.ms/api/Users/login'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: json.encode({

        'password': password,
        'username': username,

      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      return null;
    } else {
      throw Exception('Failed to login');
    }
  }

  //register method

  Future<bool> register(String name, String username , String email, String password) async{
    final response = await http.post(
      Uri.parse('https://5lcp61q9-7100.inc1.devtunnels.ms/api/Users/regester'),

      headers: {
        'Content-Type': 'application/json',
      },

      body: json.encode({

        'name': name,
        'username': username,
        'email': email,
        'password': password,


      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      throw Exception('Failed to login');
    }

  }

}