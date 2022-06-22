import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/request_implementation/request_data_repository.dart';
import 'package:storm_application/request_implementation/request.dart';
import 'package:flutter/material.dart';

import 'chat_details_page.dart';

class RequestDetailsPage extends StatefulWidget {
    final Request request;
    const RequestDetailsPage({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPage();
}

class _RequestDetailsPage extends State<RequestDetailsPage> {
  final RequestDataRepository repository = RequestDataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top : 50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Home screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.request.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),

              // Spacer box
              const SizedBox(height: 5),

              const Text('By user: '),

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
                      child: Text(widget.request.description)
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
                          child: Text("Post date: " + widget.request.date,
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

              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ChatDetailPage();
                  }));
                },
                color: Colors.green,
                child: const Text("Initiate Conversation",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.indigo,
                child: const Text("Back to Request List",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
