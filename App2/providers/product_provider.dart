import 'package:flutter/material.dart';
import '../data/ProductService.dart';

class ProductProvider extends ChangeNotifier {

  final ProductService _productService =
  ProductService();

  List<dynamic> products = [];

  bool isLoading = false;

  Future<void> getProducts() async {

    isLoading = true;
    notifyListeners();

    try {

      products =
      await _productService.getProducts();

    } catch (e) {

      debugPrint(e.toString());

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }
}