import 'dart:convert';
import 'package:http/http.dart' as http;
import 'conncetion.dart';

class CategoryService {

  Future<List<String>> getCategories() async {

    final response = await http.get(
      Uri.parse(ConnectionString.Category),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return List<String>.from(
        data.map((cat) => cat["categoryName"]),
      );

    } else {
      throw Exception("Failed to load categories");
    }
  }
}