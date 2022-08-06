import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String _currentUserName = "";
  String _categoryKeyword = "";
  String _usernameKeyword = "";

  @override
  Widget build(BuildContext context) {
    return _buildOfferList(context);
  }

  Widget _buildOfferList(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot ds) {
      setState(() {
        _currentUserName = ds.get("firstName") + " " + ds.get("lastName");
      });
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Offer List for " + _currentUserName),
      ),

      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text("Filter By Category:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),

                    const SizedBox(width: 10),

                    MaterialButton(
                      color: Colors.grey,
                      child: const Text("All",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _categoryKeyword = "";
                          _usernameKeyword = "";
                        });
                      },
                    ),

                    const SizedBox(width: 5),

                    MaterialButton(
                      color: Colors.orange,
                      child: const Text("By me",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _categoryKeyword = "";
                          _usernameKeyword = _currentUserName;
                        });
                      },
                    ),

                    const SizedBox(width: 5),

                    MaterialButton(
                      color: Colors.red,
                      child: const Text("Tech",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _categoryKeyword = "Tech";
                          _usernameKeyword = "";
                        });
                      },
                    ),

                    const SizedBox(width: 5),

                    MaterialButton(
                      color: Colors.green,
                      child: const Text("Delivery",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _categoryKeyword = "Delivery";
                          _usernameKeyword = "";
                        });
                      },
                    ),

                    const SizedBox(width: 5),

                    MaterialButton(
                      color: Colors.blue,
                      child: const Text("Errands",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _categoryKeyword = "Errands";
                          _usernameKeyword = "";
                        });
                      },
                    ),

                    const SizedBox(width: 5),

                    MaterialButton(
                      color: Colors.indigo,
                      child: const Text("Others",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _categoryKeyword = "Others";
                          _usernameKeyword = "";
                        });
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: repository.getStream(_categoryKeyword, _usernameKeyword),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const LinearProgressIndicator();
                  return _buildList(context, snapshot.data?.docs ?? []);
                }
            ),
          ),
        ],
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
}