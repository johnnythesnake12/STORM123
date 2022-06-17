import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String title;
  String description;
  String category;
  //DateTime date;
  String date;
  String? referenceId;

  Request(
    {required this.title,
      required this.description,
      required this.category,
      this.referenceId,
      required this.date});

  factory Request.fromSnapshot(DocumentSnapshot snapshot) {
    final newRequest = Request.fromJson(snapshot.data() as Map<String, dynamic>);
    newRequest.referenceId = snapshot.reference.id;
    return newRequest;
  }

  factory Request.fromJson(Map<String, dynamic> json) => _requestFromJson(json);

  Map<String, dynamic> toJson() => _requestToJson(this);

  @override
  String toString() => 'Request<$title>';
}

Request _requestFromJson(Map<String, dynamic> json) {
  return Request(
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    date: json['date'] as String
    //date: (json['date'] as Timestamp).toDate()
  );
}

Map<String, dynamic> _requestToJson(Request instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description' : instance.description,
      'category' : instance.category,
      'date': instance.date,
    };