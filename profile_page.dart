import 'package:flutter/material.dart';
import 'my_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
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

            const Text(
              "Abdulrhman",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "example@gmail.com",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.person_outline, color: Colors.blueAccent),
                title: const Text("Username"),
                subtitle: const Text("abdulrhman123"),
              ),
            ),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.email_outlined, color: Colors.blueAccent),
                title: const Text("Email"),
                subtitle: const Text("example@gmail.com"),
              ),
            ),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.lock_outline, color: Colors.blueAccent),
                title: const Text("Account Status"),
                subtitle: const Text("Active"),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/editProfile");
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
