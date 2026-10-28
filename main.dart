import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App2/Screens/loginScreen.dart';

import 'App2/providers/CartProvider.dart';
import 'App2/providers/OrderProvider.dart';
import 'App2/providers/UserProvider.dart';
import 'App2/providers/register_provider.dart';
import 'App2/providers/product_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => RegisterProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),

      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),

      debugShowCheckedModeBanner: false,

      home: const LoginScreen(),
    );
  }
}