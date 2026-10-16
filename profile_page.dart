import 'package:flutter/material.dart';
import 'data/user_data.dart';
import 'my_drawer.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  final UserData user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(user: user),
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              user.fullName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              user.email,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 3,
              child: ListTile(
                leading:
                const Icon(Icons.person_outline, color: Colors.blueAccent),
                title: const Text("Username"),
                subtitle: Text(user.username),
              ),
            ),

            Card(
              elevation: 3,
              child: ListTile(
                leading:
                const Icon(Icons.email_outlined, color: Colors.blueAccent),
                title: const Text("Email"),
                subtitle: Text(user.email),
              ),
            ),

            Card(
              elevation: 3,
              child: const ListTile(
                leading:
                Icon(Icons.lock_outline, color: Colors.blueAccent),
                title: Text("Account Status"),
                subtitle: Text("Active"),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(user: user),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
