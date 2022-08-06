import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:storm_application/contacts_page.dart';
import 'package:storm_application/offer_implementation/edit_offer_dialog.dart';
import 'package:storm_application/offer_implementation/offer_data_repository.dart';
import 'package:storm_application/offer_implementation/offer.dart';
import 'package:flutter/material.dart';

class OfferDetailsPage extends StatefulWidget {
  final Offer offer;
  const OfferDetailsPage({Key? key, required this.offer}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPage();
}

class _OfferDetailsPage extends State<OfferDetailsPage> {
  final OfferDataRepository repository = OfferDataRepository();
  String _currentUserName = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot ds) {
      setState(() {
        _currentUserName = ds.get("firstName") + " " + ds.get("lastName");
      });
    });

    return Scaffold(
        body: StreamBuilder<List<types.User>> (
            stream: FirebaseChatCore.instance.users(),
            initialData: const [],
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(top : 50.0),
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
                                  child: Text("Offer Type:",
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
                                  child: Text(widget.offer.category)
                              )
                            ]
                        ),
                      ),

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

                      (widget.offer.username == _currentUserName) ?
                      MaterialButton(
                          color: Colors.orange,
                          child: const Text("Edit Offer", style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            showDialog<Widget>(
                              context: context,
                              builder: (BuildContext context) {
                                return EditOfferDialog(offer: widget.offer);
                              },
                            );
                          }
                      )
                          : const SizedBox.shrink(),

                      (widget.offer.username == _currentUserName) ?
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Are you sure you want to delete your post?"),
                                  content: SingleChildScrollView(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            MaterialButton(
                                                color: Colors.red,
                                                child: const Text("Yes", style: TextStyle(color: Colors.white, fontSize: 16.0)),
                                                onPressed: () {
                                                  repository.deleteOffer(widget.offer);

                                                  Navigator.pop(context);
                                                  Navigator.pop(context);

                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return const AlertDialog(
                                                          title: Text("Success!", style: TextStyle(color: Colors.green)),
                                                          content: Text("You have successfully deleted your post."),
                                                        );
                                                      }
                                                  );

                                                }
                                            ),

                                            const SizedBox(width: 20.0),

                                            TextButton(
                                                child: const Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 16.0)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }
                                            )
                                          ]
                                      )
                                  ),
                                );
                              }
                          );
                        },
                        color: Colors.red,
                        child: const Text("Delete Offer",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )

                          : const SizedBox.shrink(),

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
