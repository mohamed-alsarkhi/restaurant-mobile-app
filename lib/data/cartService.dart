import 'dart:convert';
import 'package:http/http.dart' as http;

import 'routesApi.dart';

class Cartservice {

  Future<List<dynamic>> getCart(int UserId) async {

    final response = await http.get(
      Uri.parse('${ConnString.cart}/$UserId'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load a cart');
    }
  }
  //////////////////////////////////////////////////////////////////////////
  Future<void> AddtoCart(int UserId , int menuItemId ) async {
    final response = await http.post(
      Uri.parse(ConnString.AddinCart),

      headers: {
        'Content-Type': 'application/json',
      },

      body: json.encode({

        'userId': UserId,
        'menuItemId': menuItemId,
        'quantity': 1
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add product');
    }
  }


  Future<void> removeFromCart(
      int userId,
      int menuItemId,
      ) async {
    final response = await http.delete(
      Uri.parse('${ConnString.cart}/$userId/$menuItemId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove product');
    }
  }

}