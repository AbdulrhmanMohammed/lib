import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = "https://24fvn1bb-7068.inc1.devtunnels.ms/api/Product";

  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load products");
    }
  }
}
