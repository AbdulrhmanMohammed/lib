import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/register_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final usernameController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4facfe),
              Color(0xff00f2fe),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.person_add_alt_1,
                    size: 90,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: nameController,
                    decoration:
                    const InputDecoration(
                      labelText: "Full Name",
                      prefixIcon:
                      Icon(Icons.person),
                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller:
                    usernameController,
                    decoration:
                    const InputDecoration(
                      labelText: "Username",
                      prefixIcon:
                      Icon(Icons.badge),
                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller:
                    emailController,
                    decoration:
                    const InputDecoration(
                      labelText: "Email",
                      prefixIcon:
                      Icon(Icons.email),
                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller:
                    passwordController,
                    obscureText: true,
                    decoration:
                    const InputDecoration(
                      labelText: "Password",
                      prefixIcon:
                      Icon(Icons.lock),
                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () async {

                        if (nameController.text
                            .trim()
                            .isEmpty) {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Enter your name"),
                            ),
                          );
                          return;
                        }

                        if (usernameController
                            .text
                            .trim()
                            .isEmpty) {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Enter username"),
                            ),
                          );
                          return;
                        }

                        if (!isValidEmail(
                            emailController.text
                                .trim())) {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Invalid email"),
                            ),
                          );
                          return;
                        }

                        if (passwordController
                            .text.length <
                            6) {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Password must be at least 6 characters",
                              ),
                            ),
                          );
                          return;
                        }

                        bool success =
                        await provider
                            .register(
                          nameController.text,
                          emailController.text,
                          usernameController.text,
                          passwordController.text,
                        );

                        if (!mounted) return;

                        if (success) {

                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              backgroundColor:
                              Colors.green,
                              content: Text(
                                "Registration Successful",
                              ),
                            ),
                          );

                          Navigator.pop(
                              context);

                        } else {

                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              backgroundColor:
                              Colors.red,
                              content: Text(
                                "Username or Email already exists",
                              ),
                            ),
                          );
                        }
                      },

                      child: provider.isLoading
                          ? const CircularProgressIndicator(
                        color:
                        Colors.white,
                      )
                          : const Text(
                        "Register",
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account?",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}