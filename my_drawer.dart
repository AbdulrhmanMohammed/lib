import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Abdulrhman"),
            accountEmail: const Text("example@gmail.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home, color: Colors.blueAccent),
            title: const Text("Home"),
            onTap: () => Navigator.pushNamed(context, "/home"),
          ),

          ListTile(
            leading: const Icon(Icons.login, color: Colors.blueAccent),
            title: const Text("Login"),
            onTap: () => Navigator.pushNamed(context, "/login"),
          ),


          ListTile(
            leading: const Icon(Icons.person_add, color: Colors.blueAccent),
            title: const Text("Register"),
            onTap: () => Navigator.pushNamed(context, "/register"),
          ),

          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: const Text("Profile"),
            onTap: () => Navigator.pushNamed(context, "/profile"),
          ),


          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {},
          ),

        ],
      ),
    );
  }
}
