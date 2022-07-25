import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/review_implementation/review.dart';
import 'package:storm_application/review_implementation/review_data_repository.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AddReviewDialog extends StatefulWidget {
  final types.User reviewUserReviewing;
  final types.User reviewUserBeingReviewed;
  const AddReviewDialog({Key? key, required this.reviewUserReviewing, required this.reviewUserBeingReviewed}) : super(key: key);

  @override
  _AddReviewDialogState createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double? reviewRating;
  String? reviewText;

  final ReviewDataRepository repository = ReviewDataRepository();
  double dropdownValue = 1.0;

  @override
  Widget build(BuildContext context) {

    //String userReviewingName = widget.reviewUserReviewing.firstName! + " " + (widget.reviewUserReviewing.lastName ?? "");
    //String userBeingReviewedName = widget.reviewUserBeingReviewed.firstName! + " " + (widget.reviewUserBeingReviewed.lastName ?? "");

    return AlertDialog(
        title: const Text("Add Review"),
        content: SingleChildScrollView(
            child: ListBody(
                children: <Widget> [
                  const Text("Rating:"),

                  const SizedBox(height: 10),

                  // dropdown list
                  DropdownButton<double>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (var newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                      reviewRating = dropdownValue;
                    },
                    items: <double>[1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0]
                        .map<DropdownMenuItem<double>>((double value) {
                      return DropdownMenuItem<double>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  const Text("Review Text:"),

                  const SizedBox(height: 10),

                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Review Description"),
                    onChanged: (text) => reviewText = text,
                  ),

                ]
            )
        ),

        actions: <Widget> [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),

          TextButton(
              onPressed: () {
                if (reviewRating == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please select a rating.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else if (reviewText == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please enter your review text.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else {
                  final rev = Review(
                      rating: reviewRating!,
                      text: reviewText!,
                      userReviewing: widget.reviewUserReviewing.firstName! + " " + (widget.reviewUserReviewing.lastName ?? ""),
                      userBeingReviewed: widget.reviewUserBeingReviewed.firstName! + " " + (widget.reviewUserBeingReviewed.lastName ?? "")
                  );
                  repository.addReview(rev);
                  Navigator.of(context).pop();

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Success! Your review has been posted.", style: TextStyle(color: Colors.green)),
                        );
                      }
                  );

                }

              },
              child: const Text("Add"))
        ]
    );
  }
}