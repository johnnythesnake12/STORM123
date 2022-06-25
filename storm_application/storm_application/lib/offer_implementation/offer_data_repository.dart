import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/offer_implementation/offer.dart';

class OfferDataRepository {

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Active Offers');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addRequest(Offer offer) {
    return collection.add(offer.toJson());
  }

  void updateRequest(Offer offer) async {
    await collection.doc(offer.referenceId).update(offer.toJson());
  }

  void deleteRequest(Offer offer) async {
    await collection.doc(offer.referenceId).delete();
  }
}