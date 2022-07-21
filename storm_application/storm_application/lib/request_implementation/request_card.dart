import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:storm_application/request_details_page.dart';
import 'package:storm_application/request_implementation/request.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class RequestCard extends StatelessWidget {
  final Request request;
  final TextStyle boldStyle;

  const RequestCard({Key? key, required this.request, required this.boldStyle}) :
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RequestDetailsPage(request: request)),
        );
      },
      child: Card(
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.account_circle,
                size: 75
              ),
            ),

            Flexible (
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                        request.title,
                        style: boldStyle,
                        overflow: TextOverflow.ellipsis
                    ),
                    const SizedBox(height: 5),
                    Text(
                        request.description,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ]
                ),
              ),
            ),
            
            //_buildDeleteButton() // NEW ADDITION
            
          ]
        )
      ),
    );
  }

  /*Widget _buildDeleteButton() {
    // NEW ADDITION
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return const Icon(Icons.delete, color: Colors.red);
          }
        ),
        onTap: () {

        }
      ),
    );
  }*/
}