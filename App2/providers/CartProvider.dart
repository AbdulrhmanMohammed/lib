import 'package:flutter/material.dart';
import '../data/CartService.dart';

class CartProvider extends ChangeNotifier {

  final CartService _cartService =
  CartService();

  List<dynamic> cartItems = [];

  bool isLoading = false;

  Future<void> loadCart(int userId) async {

    isLoading = true;
    notifyListeners();

    try {

      cartItems =
      await _cartService.getCart(userId);

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(
      int userId,
      int productId,
      ) async {

    await _cartService.addToCart(
      userId,
      productId,
    );

    await loadCart(userId);
  }

  Future<void> removeFromCart(
      int userId,
      int productId,
      ) async {

    await _cartService.removeFromCart(
      userId,
      productId,
    );

    await loadCart(userId);
  }

  double getTotal() {

    double total = 0;

    for (var item in cartItems) {

      total +=
          (item["price"] as num)
              .toDouble() *
              (item["quantity"] as num)
                  .toInt();
    }

    return total;
  }
}