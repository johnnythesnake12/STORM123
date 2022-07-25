import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/review_implementation/review.dart';

class ReviewDataRepository {

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Reviews');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getFilteredStream(String userBeingReviewed) {
    return collection.where("userBeingReviewed", isEqualTo: userBeingReviewed).snapshots();
  }

  Future<DocumentReference> addReview(Review review) {
    return collection.add(review.toJson());
  }

  void updateReview(Review review) async {
    await collection.doc(review.referenceId).update(review.toJson());
  }

  void deleteReview(Review review) async {
    await collection.doc(review.referenceId).delete();
  }
}