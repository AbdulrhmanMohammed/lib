import 'package:flutter/material.dart';
import 'data/user_data.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'HomePage.dart';

class MyDrawer extends StatelessWidget {
  final UserData user;

  const MyDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.fullName),   // اسم المستخدم
            accountEmail: Text(user.email),     // الإيميل
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
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(user: user),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(user: user),
                ),
              );
            },
          ),

          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
