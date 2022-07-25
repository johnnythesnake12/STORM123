import 'package:cloud_firestore/cloud_firestore.dart';

class Offer {
  String title;
  String description;
  String category;
  String username;
  String date;
  String? referenceId;

  Offer(
      {required this.title,
        required this.description,
        required this.category,
        required this.username,
        this.referenceId,
        required this.date,
      });

  factory Offer.fromSnapshot(DocumentSnapshot snapshot) {
    final newOffer = Offer.fromJson(snapshot.data() as Map<String, dynamic>);
    newOffer.referenceId = snapshot.reference.id;
    return newOffer;
  }

  factory Offer.fromJson(Map<String, dynamic> json) => _offerFromJson(json);

  Map<String, dynamic> toJson() => _offerToJson(this);

  @override
  String toString() => 'Offer<$title>';
}

Offer _offerFromJson(Map<String, dynamic> json) {
  return Offer(
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      username: json['username'] as String,
      date: json['date'] as String,
  );
}

Map<String, dynamic> _offerToJson(Offer instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description' : instance.description,
      'category' : instance.category,
      'username' : instance.username,
      'date': instance.date
    };