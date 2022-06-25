import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/request_implementation/request.dart';

class RequestDataRepository {

  final CollectionReference collection =
  FirebaseFirestore.instance.collection('Active Requests');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
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