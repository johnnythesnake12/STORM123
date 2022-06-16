import 'package:flutter/material.dart';
import 'package:storm_application/request.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  final TextStyle boldStyle;

  RequestCard({Key? key, required this.request, required this.boldStyle}) :
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0),
        child: Text(request.title, style: boldStyle),
              )
            )
          ]
        )
      )
    );
  }
}