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
    MaterialColor colorSelector(String category) {
      Map colorPalette =
        {"Tech" : Colors.red,
        "Delivery" : Colors.green,
        "Errands" : Colors.blue,
        "Others" : Colors.indigo};
      return colorPalette[category]!;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RequestDetailsPage(request: request)),
        );
      },
      child: Card(
        shape: Border(left: BorderSide(color: colorSelector(request.category), width: 5)),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 10.0),

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
            ),
            
            //_buildDeleteButton() // NEW ADDITION
            
          ]
        )
      ),
    );
  }

  /*Widget _buildDeleteButton() {
    // NEW ADDITION
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return const Icon(Icons.delete, color: Colors.red);
          }
        ),
        onTap: () {

        }
      ),
    );
  }*/
}