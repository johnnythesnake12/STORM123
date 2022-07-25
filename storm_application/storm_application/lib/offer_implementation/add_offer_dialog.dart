import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'offer.dart';
import 'offer_data_repository.dart';
//import 'package:storm_application/request_implementation/offer_data_repository.dart';
//import 'package:storm_application/request_implementation/offer.dart';

class AddOfferDialog extends StatefulWidget {
  const AddOfferDialog({Key? key}) : super(key: key);

  @override
  _AddOfferDialogState createState() => _AddOfferDialogState();
}

class _AddOfferDialogState extends State<AddOfferDialog> {
  String? offerTitle;
  String? offerDescription;
  String? offerType;
  String? offerDate = DateTime.now().toString();
  String? offerUsername;
  bool offerIsAccepted = false;

  final OfferDataRepository repository = OfferDataRepository();

  @override
  Widget build(BuildContext context) {
    /*var thing = FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {});*/

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    FutureBuilder<DocumentSnapshot> futureBuilder = FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          offerUsername = "${data['firstName']} ${data['lastName']}";
          return Container(width: 285);
        }
    );

    return AlertDialog(
        title: const Text("Add Offer"),
        content: SingleChildScrollView(
            child: ListBody(
                children: <Widget> [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Offer Title"),
                    onChanged: (text) => offerTitle = text,
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Offer Description"),
                    onChanged: (text) => offerDescription = text,
                  ),

                  const SizedBox(height: 20),

                  const Text("Offer Type:"),

                  const SizedBox(height: 10),

                  RadioListTile(
                    title: const Text('Tech'),
                    value: 'Tech',
                    groupValue: offerType,
                    onChanged: (value) {
                      setState(() {
                        offerType = value as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Delivery'),
                    value: 'Delivery',
                    groupValue: offerType,
                    onChanged: (value) {
                      setState(() {
                        offerType = (value ?? '') as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Errands'),
                    value: 'Errands',
                    groupValue: offerType,
                    onChanged: (value) {
                      setState(() {
                        offerType = (value ?? '') as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Other'),
                    value: 'other',
                    groupValue: offerType,
                    onChanged: (value) {
                      setState(() {
                        offerType = (value ?? '') as String;
                      });
                    },
                  ),

                  futureBuilder

                ]
            )
        ),

        actions: <Widget> [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),

          TextButton(
              onPressed: () {
                if (offerTitle == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please enter a title for your offer.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else if (offerDescription == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please enter a description of your offer.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else if (offerType == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please select a category for your offer.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else {
                  final offer = Offer(
                      title: offerTitle!,
                      description: offerDescription!,
                      category: offerType!,
                      username: offerUsername!,
                      date: offerDate!,
                  );
                  repository.addRequest(offer);
                  Navigator.of(context).pop();

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Success! Your offer has been posted.", style: TextStyle(color: Colors.green)),
                        );
                      }
                  );
                }
              },
              child: const Text("Add"))
        ]
    );
  }
}