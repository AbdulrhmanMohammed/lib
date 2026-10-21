
import 'package:flutter/material.dart';
import 'data/user_data.dart';
import 'profile_page.dart';
import 'login_page.dart';
import 'HomePage.dart';
import 'cartScreen.dart';

class MyDrawer extends StatelessWidget {
  final UserData user;

  const MyDrawer({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.fullName),
            accountEmail: Text(user.email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.blueAccent,
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),

          // Home
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(user: user),
                ),
                    (route) => false,
              );
            },
          ),

          // Cart
          ListTile(
            leading: const Icon(
              Icons.shopping_basket,
              color: Colors.blueAccent,
            ),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(user.userId),
                ),
              );
            },
          ),

          // Profile
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.blueAccent,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(user: user),
                ),
              );
            },
          ),

          const Spacer(),

          // Logout
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
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
