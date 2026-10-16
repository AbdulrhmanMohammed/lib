import 'package:flutter/material.dart';
import 'data/user_data.dart';
import 'my_drawer.dart';
import 'my_drawer_right.dart';


class HomePage extends StatelessWidget {
  final UserData user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(user: user),
      endDrawer: MyDrawerRight(user: user),

      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blueAccent,
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
          "Welcome",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
