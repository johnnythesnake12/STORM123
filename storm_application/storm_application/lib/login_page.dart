// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static const emailSnackBar = SnackBar(
    content: Text(
      "Error: Please enter an email address",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  static const passwordSnackBar = SnackBar(
    content: Text(
      "Error: Please enter a password",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  static const noUserSnackBar = SnackBar(
    content: Text(
      "Error: No user found for that email",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  static const wrongPasswordSnackBar = SnackBar(
    content: Text(
      "Error: Invalid password",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  Future signIn() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(emailSnackBar);
    }

    else if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
    }

    else {
      try {
        UserCredential cred =  await FirebaseAuth
            .instance
            .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          ScaffoldMessenger.of(context).showSnackBar(noUserSnackBar);
        } else if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar(wrongPasswordSnackBar);
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child:SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // STORM logo
                  Image.asset(
                      'assets/images/storm_logo.png',
                      scale: 4
                  ),

                  // Spacer box
                  const SizedBox(height: 50),

                  // Login to STORM
                  const Text(
                    "Login to STORM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

                  // Please enter your login information
                  const Text(
                    "Please enter your login information",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 30),

                  // Email box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Email",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

                  // Password box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Password",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

                  // Sign In Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn, // to implement
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 20),

                  // New to STORM? Register now.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // New to STORM?
                      const Text(
                        "New to STORM? ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Register now
                      GestureDetector(
                          child: const Text(
                            "Register now.",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          }
                      ),
                    ],
                  ),

                  // Spacer box
                  const SizedBox(height: 20),

                ]
            ),
          ),
        ),
      ),
    );
  }
}