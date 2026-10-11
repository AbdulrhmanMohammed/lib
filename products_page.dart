import 'package:flutter/material.dart';
import 'my_drawer.dart';
import 'my_drawer_right.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),          // الدرو اليسار الأساسي
      endDrawer: const MyDrawerRight(),   // الدرو اليمين (Products فقط)

      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.blueAccent,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // يفتح الدرو اليمين
              },
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),
        children: const [
          ProductItem(name: "Laptop", price: "3500 SAR", stock: 12),
          ProductItem(name: "Keyboard", price: "150 SAR", stock: 40),
          ProductItem(name: "Mouse", price: "80 SAR", stock: 60),
          ProductItem(name: "Monitor", price: "900 SAR", stock: 20),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String price;
  final int stock;

  const ProductItem({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.inventory, color: Colors.blueAccent),
        title: Text(name),
        subtitle: Text("Price: $price\nStock: $stock"),
      ),
    );
  }
}
