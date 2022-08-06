import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/request_implementation/request.dart';

class RequestDataRepository {

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Active Requests');

  Stream<QuerySnapshot> getStream(String categoryKeyword, String usernameKeyword) {
    if (categoryKeyword == "" && usernameKeyword == "") {
      return collection.orderBy("date", descending: true).snapshots();
    }

    else if (usernameKeyword == "") {
      return collection.where("category", isEqualTo: categoryKeyword).snapshots();
    }

    return collection.where("username", isEqualTo: usernameKeyword).snapshots();
  }

  Future<DocumentReference> addRequest(Request request) {
    return collection.add(request.toJson());
  }

  void updateRequest(Request request) async {
    await collection.doc(request.referenceId).update(request.toJson());
  }

  void deleteRequest(Request request) async {
    await collection.doc(request.referenceId).delete();
  }
}