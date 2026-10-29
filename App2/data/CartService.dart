import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/conncetion.dart';

class CartService {
  Future<List<dynamic>> getCart(int userId) async {
    final response = await http.get(
      Uri.parse(
        '${ConnectionString.cart}/$userId',
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Failed to load cart');
  }

  Future<void> addToCart(
      int userId,
      int productId,
      ) async {
    final response = await http.post(
      Uri.parse(ConnectionString.cart),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'userId': userId,
          'productId': productId,
          'quantity': 1,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to add product',
      );
    }
  }

  Future<void> increaseQuantity(
      int userId,
      int productId,
      ) async {
    final response = await http.put(
      Uri.parse(
        '${ConnectionString.cart}/increase/$userId/$productId',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to increase quantity',
      );
    }
  }

  Future<void> decreaseQuantity(
      int userId,
      int productId,
      ) async {
    final response = await http.put(
      Uri.parse(
        '${ConnectionString.cart}/decrease/$userId/$productId',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to decrease quantity',
      );
    }
  }

  Future<void> removeFromCart(
      int userId,
      int productId,
      ) async {
    final response = await http.delete(
      Uri.parse(
        '${ConnectionString.cart}/$userId/$productId',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to remove product',
      );
    }
  }
}