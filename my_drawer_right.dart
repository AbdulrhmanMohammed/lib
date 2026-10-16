import 'package:flutter/material.dart';
import 'data/user_data.dart';

import 'products_page.dart';
import 'category_page.dart';

class MyDrawerRight extends StatelessWidget {
  final UserData user;

  const MyDrawerRight({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.category),
            title: const Text("Categories"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryPage(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Products"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
