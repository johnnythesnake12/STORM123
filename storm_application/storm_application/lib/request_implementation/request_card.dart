import 'package:flutter/material.dart';
import 'package:storm_application/request_details_page.dart';
import 'package:storm_application/request_implementation/request.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  final TextStyle boldStyle;

  const RequestCard({Key? key, required this.request, required this.boldStyle}) :
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RequestDetailsPage(request: request)),
        );
      },
      child: Card(
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.account_circle,
                size: 75
              ),
            ),

            Flexible (
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0),
                child: Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text(
                        request.title,
                        style: boldStyle,
                        overflow: TextOverflow.ellipsis
                    ),
                    const SizedBox(height: 5),
                    Text(
                        request.description,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ]
                ),
              ),
            )
          ]
        )
      ),
    );
  }
}