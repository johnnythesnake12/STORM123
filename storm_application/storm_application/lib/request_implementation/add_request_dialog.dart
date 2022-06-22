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
  //DateTime requestDate = DateTime.now();

  final RequestDataRepository repository = RequestDataRepository();

  @override
  Widget build(BuildContext context) {
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

            SizedBox(height: 10),

            TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Request Description"),
              onChanged: (text) => requestDescription = text,
            ),

            SizedBox(height: 20),

            const Text("Request Type:"),

           SizedBox(height: 10),

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
            )

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
            if (requestTitle != null && requestDescription != null && requestType != null) {
              final req = Request(
                  title: requestTitle!,
                  description: requestDescription!,
                  category: requestType!,
                  date: requestDate!);
              repository.addRequest(req);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Add"))
      ]
    );
  }
}