import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key ? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController= TextEditingController();
  final _passwordConfirmController = TextEditingController();

  static const passwordSnackBar = SnackBar(
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
    if (_passwordController.text.trim() == _passwordConfirmController.text.trim()) {
      await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(signupSuccessSnackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(passwordSnackBar);
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
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign up for STORM
                  Text(
                    "Sign up for STORM",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  // Spacer box
                  SizedBox(height: 10),

                  // Please enter your information below
                  Text(
                    "Please enter your information below",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  // Spacer box
                  SizedBox(height: 30),

                  // Email box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Email",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  SizedBox(height: 10),

                  // Password box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Password",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  SizedBox(height: 10),

                  // Confirm password box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _passwordConfirmController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Confirm Password",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),

                  // Spacer box
                  SizedBox(height: 10),

                  // Sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Center(
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
                  SizedBox(height: 20),

                  // Back to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
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
                  SizedBox(height: 20),

                ]
            ),
          ),
        ),
      ),
    );
  }
}