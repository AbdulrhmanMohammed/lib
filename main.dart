import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'edit_profile_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'profile_page.dart';
import 'products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: "/home",

      routes: {
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/profile": (context) => const ProfilePage(),
        "/editProfile": (context) => const EditProfilePage(),
        "/products": (context) => const ProductsPage(),
      },
    );
  }
}
