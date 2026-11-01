import 'package:flutter/material.dart';

import '../data/CategoryService.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService =
  CategoryService();

  List<String> categories = [];

  bool isLoading = false;

  Future<void> loadCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      categories =
      await _categoryService.getCategories();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}