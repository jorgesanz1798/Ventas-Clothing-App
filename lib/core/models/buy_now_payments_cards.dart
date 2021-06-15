import 'package:flutter/material.dart';

class BuyNowSinglePaymentCard extends StatefulWidget {
  final cardNumber;
  final cardHolderName;
  final cvvNumber;
  final expiryDate;

  BuyNowSinglePaymentCard(
    this.cardNumber,
    this.cardHolderName,
    this.cvvNumber,
    this.expiryDate,
  );

  @override
  _BuyNowSinglePaymentCardState createState() =>
      _BuyNowSinglePaymentCardState();
}

class _BuyNowSinglePaymentCardState extends State<BuyNowSinglePaymentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[100],
        height: 10,
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 25)),
            Container(
              width: 80,
              constraints: BoxConstraints(minWidth: 80, maxWidth: 80),
              child: Icon(
                Icons.credit_card,
                color: Colors.black,
                size: 100,
              ),
            ),
            Padding(padding: const EdgeInsets.only(right: 25)),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 180,
                constraints: BoxConstraints(minWidth: 180, maxWidth: 180),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 25)),
                    Text(
                      widget.cardNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.cardHolderName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.expiryDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
