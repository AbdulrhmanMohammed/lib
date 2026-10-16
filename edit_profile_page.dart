import 'package:flutter/material.dart';
import 'data/user_data.dart';
import 'my_drawer.dart';


class EditProfilePage extends StatelessWidget {
  final UserData user;

  const EditProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
    TextEditingController(text: user.username);
    final TextEditingController fullNameController =
    TextEditingController(text: user.fullName);
    final TextEditingController emailController =
    TextEditingController(text: user.email);

    return Scaffold(
      drawer: MyDrawer(user: user),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.blueAccent,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.badge),
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {
                // هنا لاحقًا تربطها بـ API أو تخزين محلي
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Save Changes"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
