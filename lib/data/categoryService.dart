import 'dart:convert';
import 'package:http/http.dart' as http;

class Categoryservice {

  Future<List<dynamic>> getCategorys() async {

    final response = await http.get(
      Uri.parse('https://5lcp61q9-7100.inc1.devtunnels.ms/api/menu/categorys'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}