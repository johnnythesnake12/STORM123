import 'package:flutter/material.dart';
import 'package:storm_application/offer_details_page.dart';
import 'package:storm_application/offer_implementation/offer.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final TextStyle boldStyle;

  const OfferCard({Key? key, required this.offer, required this.boldStyle}) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OfferDetailsPage(offer: offer)),
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
                              offer.title,
                              style: boldStyle,
                              overflow: TextOverflow.ellipsis
                          ),
                          const SizedBox(height: 5),
                          Text(
                            offer.description,
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