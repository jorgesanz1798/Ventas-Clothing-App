import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/add_paycard_screen.dart';

class BuyNowPaymentsCards extends StatefulWidget {
  @override
  _BuyNowPaymentsCardsState createState() => _BuyNowPaymentsCardsState();
}

class _BuyNowPaymentsCardsState extends State<BuyNowPaymentsCards> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    // ignore: unnecessary_null_comparison
    if (_user != null) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('payments_cards')
            .where("user", isEqualTo: "${_user.uid}")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.credit_card,
                      color: Colors.black,
                      size: 100,
                    ),
                    Text(
                      'You dont have a payment card yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MaterialButton(
                        onPressed: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (context) => AddCreditCardScreen(),
                          ),
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                        elevation: 0.2,
                        child: new Text('Add a payment card'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width / (150),
              ),
              children: snapshot.data!.docs.map(
                (document) {
                  var cardNumber = document['cardNumber'];
                  var cardHolderName = document['cardHolderName'];
                  var cvvNumber = document['cvvNumber'];
                  var expiryDate = document['expiryDate'];
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Container(
                          height: 150,
                          child: new BuyNowSinglePaymentCard(cardNumber,
                              cardHolderName, cvvNumber, expiryDate),
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          );
        },
      );
    }
    return Text('No has iniciado sesion');
  }
}

// ignore: must_be_immutable
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
  bool selected = false;
  void selectPaymentCard() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(selected.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[100],
        height: 10,
        child: Row(
          children: [
            Padding(padding: const EdgeInsets.only(right: 25)),
            new Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: new IconButton(
                      icon: Icon(
                        selected == true ? Icons.circle : Icons.circle_outlined,
                        color: selected == true ? Colors.blue : Colors.black,
                      ),
                      onPressed: () {
                        selectPaymentCard();
                      },
                    ),
                  ),
                )
              ],
            ),
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
