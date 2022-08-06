import 'package:flutter/material.dart';
import 'package:storm_application/request_details_page.dart';
import 'package:storm_application/request_implementation/request.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:storm_application/review_implementation/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(review.rating.toString() + "/5.0", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 20),
                          Text("User Being Reviewed: " + review.userBeingReviewed.toString()),
                          const SizedBox(height: 10),
                          Text("User Reviewing: " + review.userReviewing.toString()),
                          const SizedBox(height: 20),
                          Text('"' + review.text + '"', style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16))
                        ],
                      ))
              );
            }
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
                              review.userReviewing + " to " + review.userBeingReviewed + ": " + review.rating.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis
                          ),
                          const SizedBox(height: 5),
                          Text(
                            review.text,
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
}