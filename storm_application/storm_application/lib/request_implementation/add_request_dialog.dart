import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/request_implementation/request_data_repository.dart';
import 'package:storm_application/request_implementation/request.dart';

class AddRequestDialog extends StatefulWidget {
  const AddRequestDialog({Key? key}) : super(key: key);

  @override
  _AddRequestDialogState createState() => _AddRequestDialogState();
}

class _AddRequestDialogState extends State<AddRequestDialog> {
  String? requestTitle;
  String? requestDescription;
  String? requestType;
  String? requestDate = DateTime.now().toString();
  String? requestUsername;

  final RequestDataRepository repository = RequestDataRepository();

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
          requestUsername = "${data['firstName']} ${data['lastName']}";
          return Container(width: 285);
        }
    );

    return AlertDialog(
        title: const Text("Add Request"),
        content: SingleChildScrollView(
            child: ListBody(
                children: <Widget> [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Request Title"),
                    onChanged: (text) => requestTitle = text,
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Request Description"),
                    onChanged: (text) => requestDescription = text,
                  ),

                  const SizedBox(height: 20),

                  const Text("Request Type:"),

                  const SizedBox(height: 10),

                  RadioListTile(
                    title: const Text('Tech'),
                    value: 'Tech',
                    groupValue: requestType,
                    onChanged: (value) {
                      setState(() {
                        requestType = value as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Delivery'),
                    value: 'Delivery',
                    groupValue: requestType,
                    onChanged: (value) {
                      setState(() {
                        requestType = (value ?? '') as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Errands'),
                    value: 'Errands',
                    groupValue: requestType,
                    onChanged: (value) {
                      setState(() {
                        requestType = (value ?? '') as String;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Other'),
                    value: 'other',
                    groupValue: requestType,
                    onChanged: (value) {
                      setState(() {
                        requestType = (value ?? '') as String;
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
                if (requestTitle == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please enter a title for your request.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else if (requestDescription == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please enter a description of your request.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else if (requestType == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Error: Please select a category for your request.", style: TextStyle(color: Colors.red)),
                        );
                      }
                  );
                }

                else {
                  final req = Request(
                      title: requestTitle!,
                      description: requestDescription!,
                      category: requestType!,
                      username: requestUsername!,
                      date: requestDate!);
                  repository.addRequest(req);
                  Navigator.of(context).pop();

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Success! Your request has been posted.", style: TextStyle(color: Colors.green)),
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