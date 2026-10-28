import 'package:flutter/material.dart';
import '../data/OrderService.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();

  List<dynamic> orders = [];

  bool isLoading = false;

  Future<void> loadOrders(int userId) async {
    isLoading = true;
    notifyListeners();

    try {
      orders = await _orderService.getMyOrders(userId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> makeOrder(int userId) async {
    final orderId =
    await _orderService.makeOrder(userId);

    await loadOrders(userId);

    return orderId;
  }

  Future<void> refreshOrders(int userId) async {
    await loadOrders(userId);
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;

      case 'delivered':
        return Colors.green;

      case 'cancelled':
        return Colors.red;

      default:
        return Colors.indigo;
    }
  }
}