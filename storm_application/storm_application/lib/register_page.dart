import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key ? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController= TextEditingController();
  final _passwordConfirmController = TextEditingController();

  static const firstNameSnackBar = SnackBar(
    content: Text(
      "Error: Please enter your first name",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

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

  static const tooShortSnackBar = SnackBar(
    content: Text(
      "Error: Password must be at least 6 characters long",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  static const passwordConfirmSnackBar = SnackBar(
    content: Text(
      "Error: Please confirm your password",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  static const differentPasswordSnackBar = SnackBar(
    content: Text(
      "Error: Passwords do not match",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.red,
  );

  static const signupSuccessSnackBar = SnackBar(
    content: Text(
      "Successfully signed up! You are now logged in.",
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Colors.green,
  );

  Future signUp() async {
    if (_firstNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(firstNameSnackBar);
    }

    else if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(emailSnackBar);
    }

    else if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
    }

    else if (_passwordController.text.trim().length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(tooShortSnackBar);
    }

    else if (_passwordConfirmController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(passwordConfirmSnackBar);
    }

    else if (_passwordController.text.trim() != _passwordConfirmController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(differentPasswordSnackBar);
    }

    else {
      var credential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            id: credential.user!.uid
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(signupSuccessSnackBar);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign up for STORM
                  const Text(
                    "Sign up for STORM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

                  // Please enter your information below
                  const Text(
                    "Please enter your information below",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "First Name",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Last Name",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

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

                  // Confirm password box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _passwordConfirmController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Confirm Password",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  const SizedBox(height: 10),

                  // Sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: const Center(
                          child: Text(
                            "Sign Up",
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

                  // Back to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                            "Back to Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      )
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