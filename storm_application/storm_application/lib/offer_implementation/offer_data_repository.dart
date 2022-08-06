import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/offer_implementation/offer.dart';

class OfferDataRepository {

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Active Offers');

  Stream<QuerySnapshot> getStream(String categoryKeyword, String usernameKeyword) {
    if (categoryKeyword == "" && usernameKeyword == "") {
      return collection.orderBy("date", descending: true).snapshots();
    }

    else if (usernameKeyword == "") {
      return collection.where("category", isEqualTo: categoryKeyword).snapshots();
    }

    return collection.where("username", isEqualTo: usernameKeyword).snapshots();
  }

  Future<DocumentReference> addOffer(Offer offer) {
    return collection.add(offer.toJson());
  }

  void updateOffer(Offer offer) async {
    await collection.doc(offer.referenceId).update(offer.toJson());
  }

  void deleteOffer(Offer offer) async {
    await collection.doc(offer.referenceId).delete();
  }
}