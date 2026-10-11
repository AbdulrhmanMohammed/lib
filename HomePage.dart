import 'package:flutter/material.dart';
import 'my_drawer.dart';
import 'my_drawer_right.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),          // الدرو اليسار
      endDrawer: const MyDrawerRight(),  // الدرو اليمين

      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blueAccent,

        // زر يفتح الدرو اليمين
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),

      body: const Center(
        child: Text(
          "Welcome to Home Page",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
