import 'package:flutter/material.dart';
import '../data/ProductService.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService =
  ProductService();

  List<dynamic> products = [];

  List<dynamic> allProducts = [];

  bool isLoading = false;

  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      allProducts =
      await _productService.getProducts();

      products = List.from(allProducts);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String value) {
    if (value.trim().isEmpty) {
      products = List.from(allProducts);
    } else {
      products = allProducts.where((product) {
        return product['productName']
            .toString()
            .toLowerCase()
            .contains(
          value.toLowerCase(),
        );
      }).toList();
    }

    notifyListeners();
  }
}