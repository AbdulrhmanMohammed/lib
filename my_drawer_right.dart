import 'package:flutter/material.dart';

class MyDrawerRight extends StatelessWidget {
  const MyDrawerRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Center(
              child: Text(
                "Products",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.inventory, color: Colors.blueAccent),
            title: const Text("Products"),
            onTap: () => Navigator.pushNamed(context, "/products"),
          ),

          const Spacer(),

          ListTile(
            leading: const Icon(Icons.close, color: Colors.red),
            title: const Text("Close"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
