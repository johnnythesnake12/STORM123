import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:storm_application/review_implementation/review.dart';
import 'package:storm_application/review_implementation/review_card.dart';
import 'package:storm_application/review_implementation/review_data_repository.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ViewAllReviewsPage extends StatefulWidget {
  const ViewAllReviewsPage({Key? key}) : super(key: key);

  @override
  State<ViewAllReviewsPage> createState() => _ViewAllReviewsPageState();
}

class _ViewAllReviewsPageState extends State<ViewAllReviewsPage> {
  final ReviewDataRepository repository = ReviewDataRepository();
  final boldStyle = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildReviewList(context);
  }

  Widget _buildReviewList(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title:const Text("All Reviews"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return _buildList(context, snapshot.data?.docs ?? []);
          }
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final review = Review.fromSnapshot(snapshot);

    return ReviewCard(review: review,);
  }
// AddRequestDialog() will call function located in add_offer_dialog.dart,
// which will add a request to the list
}