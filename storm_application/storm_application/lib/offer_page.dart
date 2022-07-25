import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/offer_implementation/offer_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/offer_implementation/offer.dart';
import 'package:storm_application/offer_implementation/offer_card.dart';
import 'offer_implementation/add_offer_dialog.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  final OfferDataRepository repository = OfferDataRepository();
  final boldStyle = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildOfferList(context);
  }

  Widget _buildOfferList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const Text("Offer List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: repository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const LinearProgressIndicator();
            return _buildList(context, snapshot.data?.docs ?? []);
          }
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            _addOffer();
          },
          tooltip: "Add Offer",
          child: const Icon(Icons.add)
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final offer = Offer.fromSnapshot(snapshot);

    return OfferCard(offer: offer, boldStyle: boldStyle);
  }

  void _addOffer() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddOfferDialog();
      },
    );
  }
// AddRequestDialog() will call function located in add_offer_dialog.dart,
// which will add a request to the list
}