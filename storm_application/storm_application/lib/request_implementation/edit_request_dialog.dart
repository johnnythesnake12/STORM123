import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/request_implementation/request_data_repository.dart';
import 'package:storm_application/request_implementation/request.dart';

class EditRequestDialog extends StatefulWidget {
  final Request request;
  const EditRequestDialog({Key? key, required this.request}) : super(key: key);

  @override
  _EditRequestDialogState createState() => _EditRequestDialogState();
}

class _EditRequestDialogState extends State<EditRequestDialog> {
  final RequestDataRepository repository = RequestDataRepository();
  String dropdownValue = "Tech";

  @override
  Widget build(BuildContext context) {
    String requestTitle = widget.request.title;
    String requestDescription = widget.request.description;
    String requestType = widget.request.category;

    return AlertDialog(
        title: const Text("Edit Request"),
        content: SingleChildScrollView(
            child: ListBody(
                children: <Widget> [
                  TextFormField(
                    key: const ValueKey("requestTitle"),
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Request Title"),
                    initialValue: requestTitle,
                    onChanged: (text) => requestTitle = text,
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    key: const ValueKey("requestDescription"),
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Request Description"),
                    initialValue: requestDescription,
                    onChanged: (text) => requestDescription = text,
                  ),

                  const SizedBox(height: 20),

                  const Text("Request Type:"),

                  const SizedBox(height: 10),

                  RadioListTile(
                    title: const Text('Tech'),
                    key: const ValueKey("Tech"),
                    value: 'Tech',
                    groupValue: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value as String;
                      requestType = dropdownValue;
                      //setState(() {
                      //  dropdownValue = value;
                      //});
                    },
                  ),
                  RadioListTile(
                    title: const Text('Delivery'),
                    value: 'Delivery',
                    groupValue: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value as String;
                      requestType = dropdownValue;
                      //setState(() {
                      //  dropdownValue = value;
                      //});
                    },
                  ),
                  RadioListTile(
                    title: const Text('Errands'),
                    value: 'Errands',
                    groupValue: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value as String;
                      requestType = dropdownValue;
                      //setState(() {
                      //  dropdownValue = value;
                      //});
                    },
                  ),
                  RadioListTile(
                    title: const Text('Others'),
                    value: 'Others',
                    groupValue: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value as String;
                      requestType = dropdownValue;
                      //setState(() {
                      //  dropdownValue = value;
                      //});
                    },
                  ),

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
              key: const ValueKey("Add"),
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

                else {
                 FirebaseFirestore
                     .instance
                     .collection('Active Requests')
                     .doc(widget.request.referenceId)
                     .update({"title" : requestTitle, "description" : requestDescription, "category" : requestType});

                 Navigator.pop(context);
                 Navigator.pop(context);

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Success! Your request has been edited.", style: TextStyle(color: Colors.green)),
                        );
                      }
                  );

                }

              },
              child: const Text("Confirm Edit"))
        ]
    );
  }
}