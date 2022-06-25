import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:storm_application/contacts_page.dart';
import 'package:storm_application/offer_implementation/offer_data_repository.dart';
import 'package:storm_application/offer_implementation/offer.dart';
import 'package:flutter/material.dart';

import 'chat_details_page.dart';

class OfferDetailsPage extends StatefulWidget {
  final Offer offer;
  const OfferDetailsPage({Key? key, required this.offer}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPage();
}

class _OfferDetailsPage extends State<OfferDetailsPage> {
  final OfferDataRepository repository = OfferDataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<types.User>>(
            stream: FirebaseChatCore.instance.users(),
            initialData: const [],
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Home screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.offer.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),

                      // Spacer box
                      const SizedBox(height: 5),

                      Text("By User: " + widget.offer.username),

                      // Spacer box
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            children: const [
                              Flexible(
                                  child: Text("Description:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              )
                            ]
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            children: [
                              Flexible(
                                  child: Text(widget.offer.description)
                              )
                            ]
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                            children: [
                              Flexible(
                                  child: Text("Post date: " + widget.offer.date,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic
                                      )
                                  )
                              )
                            ]
                        ),
                      ),

                      const SizedBox(height: 40),

                      _buildButton(snapshot),

                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.indigo,
                        child: const Text("Back to Offer List",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              );
            }
        )
    );
  }

  Widget _buildButton(AsyncSnapshot snapshot) {
    int length = snapshot.data.length;
    types.User? user;
    for (int i = 0; i < length; i++) {
      String currUserName = snapshot.data[i].firstName + " " +
          snapshot.data[i].lastName;
      if (currUserName == widget.offer.username) {
        user = snapshot.data[i];
      }
    }

    return MaterialButton(
        onPressed: () {
          if (user != null) {
            FirebaseChatCore.instance.createRoom(user);
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContactsPage()),
          );
        },
        color: Colors.green,
        child: const Text("Add to / Find in Contacts",
          style: TextStyle(
            color: Colors.white,
          ),
        )
    );
  }

}