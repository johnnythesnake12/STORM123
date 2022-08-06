import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/offer_implementation/offer_data_repository.dart';
import 'package:storm_application/offer_implementation/offer.dart';

class EditOfferDialog extends StatefulWidget {
  final Offer offer;
  const EditOfferDialog({Key? key, required this.offer}) : super(key: key);

  @override
  _EditOfferDialogState createState() => _EditOfferDialogState();
}

class _EditOfferDialogState extends State<EditOfferDialog> {
  final OfferDataRepository repository = OfferDataRepository();
  String dropdownValue = "Tech";

  @override
  Widget build(BuildContext context) {
    String offerTitle = widget.offer.title;
    String offerDescription = widget.offer.description;
    String offerType = widget.offer.category;

    return AlertDialog(
        title: const Text("Edit Offer"),
        content: SingleChildScrollView(
            child: ListBody(
                children: <Widget> [
                  TextFormField(
                    key: const ValueKey("offerTitle"),
                    autofocus: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Offer Title"),
                    initialValue: offerTitle,
                    onChanged: (text) => offerTitle = text,
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    key: const ValueKey("offerDescription"),
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Offer Description"),
                    initialValue: offerDescription,
                    onChanged: (text) => offerDescription = text,
                  ),

                  const SizedBox(height: 20),

                  const Text("Offer Type:"),

                  const SizedBox(height: 10),

                  RadioListTile(
                    title: const Text('Tech'),
                    key: const ValueKey("Tech"),
                    value: 'Tech',
                    groupValue: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value as String;
                      offerType = dropdownValue;
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
                      offerType = dropdownValue;
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
                      offerType = dropdownValue;
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
                      offerType = dropdownValue;
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

                else {
                  FirebaseFirestore
                      .instance
                      .collection('Active Offers')
                      .doc(widget.offer.referenceId)
                      .update({"title" : offerTitle, "description" : offerDescription, "category" : offerType});

                  Navigator.pop(context);
                  Navigator.pop(context);

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text("Success! Your offer has been edited.", style: TextStyle(color: Colors.green)),
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