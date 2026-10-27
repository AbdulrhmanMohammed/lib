import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/UserProvider.dart';
import 'homeScreen.dart';
import 'registerScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final usernameController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider =
    Provider.of<UserProvider>(context);

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
              margin:
              const EdgeInsets.symmetric(
                horizontal: 25,
              ),

              padding:
              const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.lock_open,
                    size: 90,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller:
                    usernameController,
                    decoration:
                    const InputDecoration(
                      labelText: "Username",
                      prefixIcon:
                      Icon(Icons.person),
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

                        if (usernameController
                            .text
                            .trim()
                            .isEmpty) {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Enter username",
                              ),
                            ),
                          );
                          return;
                        }

                        if (passwordController
                            .text
                            .isEmpty) {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Enter password",
                              ),
                            ),
                          );
                          return;
                        }

                        if (passwordController
                            .text
                            .length <
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
                        await provider.login(
                          usernameController.text,
                          passwordController.text,
                        );

                        if (!mounted) return;

                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const HomeScreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(
                              context)
                              .showSnackBar(
                            const SnackBar(
                              backgroundColor:
                              Colors.red,
                              content: Text(
                                "Invalid username or password",
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
                        "Login",
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create New Account",
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