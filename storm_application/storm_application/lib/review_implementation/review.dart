import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class Review {
  double rating;
  String text;
  String userReviewing;
  String userBeingReviewed;

  String? referenceId;

  Review(
      {required this.rating,
        required this.text,
        required this.userReviewing,
        required this.userBeingReviewed,
      }
  );

  factory Review.fromSnapshot(DocumentSnapshot snapshot) {
    final newReview = Review.fromJson(snapshot.data() as Map<String, dynamic>);
    newReview.referenceId = snapshot.reference.id;
    return newReview;
  }

  factory Review.fromJson(Map<String, dynamic> json) => _reviewFromJson(json);

  Map<String, dynamic> toJson() => _reviewToJson(this);

  @override
  String toString() => 'Review';
}

Review _reviewFromJson(Map<String, dynamic> json) {
  return Review(
    rating: json['rating'] as double,
    text: json['reviewText'] as String,
    userReviewing: json['userReviewing'] as String,
    userBeingReviewed: json['userBeingReviewed'] as String,
  );
}

Map<String, dynamic> _reviewToJson(Review instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'reviewText' : instance.text,
      'userReviewing' : instance.userReviewing,
      'userBeingReviewed' : instance.userBeingReviewed,
    };