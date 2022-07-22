import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/contacts_page.dart';
import 'package:storm_application/offer_page.dart';
import 'package:storm_application/request_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Home screen
            Flexible(
              child: FutureBuilder<DocumentSnapshot>(
                future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        return Text("Welcome, ${data['firstName']} ${data['lastName']}!",
                          style: const TextStyle(
                            fontWeight:FontWeight.bold,
                            fontSize: 28
                          ));
                      }
              ),
            ),

            // Spacer box
            const SizedBox(height: 5),

            // Signed in as: [user email]
            Text("(" + user.email! + ")"),

            // Spacer box
            const SizedBox(height: 30),

            MaterialButton(
              key: const ValueKey("RequestPage"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestPage()),
                );
              },
              color: Colors.indigo,
              child: const Text("Request Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OfferPage()),
                );
              },
              color: Colors.lightBlue,
              child: const Text("Offers Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactsPage()),
                );
              },
              color: Colors.green,
              child: const Text("Contacts Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            // Sign out button
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurple,
              child: const Text("Sign Out",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}