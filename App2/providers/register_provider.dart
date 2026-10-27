import 'package:flutter/material.dart';
import '../data/UserService.dart';

class RegisterProvider extends ChangeNotifier {

  final UserService _userService =
  UserService();

  bool isLoading = false;

  Future<bool> register(
      String name,
      String email,
      String username,
      String password,
      ) async {

    isLoading = true;
    notifyListeners();

    try {

      final result =
      await _userService.register(
        name,
        email,
        username,
        password,
      );

      return result != null;

    } finally {

      isLoading = false;
      notifyListeners();
    }
  }
}