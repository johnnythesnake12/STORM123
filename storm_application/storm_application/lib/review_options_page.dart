import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/contacts_page.dart';
import 'package:storm_application/offer_page.dart';
import 'package:storm_application/request_page.dart';
import 'package:storm_application/misc/review_page.dart';
import 'package:storm_application/review_user_page.dart';
import 'package:storm_application/view_all_reviews.dart';

class ReviewOptionsPage extends StatefulWidget {
  const ReviewOptionsPage({Key? key}) : super(key: key);

  @override
  State<ReviewOptionsPage> createState() => _ReviewOptionsPageState();
}

class _ReviewOptionsPageState extends State<ReviewOptionsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text("Review Options", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

            const SizedBox(height: 30),

            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReviewUserPage()),
                );
              },
              color: Colors.deepOrange,
              child: const Text("Write a Review",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            // Sign out button
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewAllReviewsPage()),
                );
              },
              color: Colors.orangeAccent,
              child: const Text("View All Reviews",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.deepPurple,
              child: const Text("Back to Home Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}