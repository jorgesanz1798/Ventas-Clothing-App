import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ventasclothing/view/screens/add_paycard_screen.dart';

class PaymentsCards extends StatefulWidget {
  @override
  _PaymentsCardsState createState() => _PaymentsCardsState();
}

class _PaymentsCardsState extends State<PaymentsCards> {
  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    print(_user!.uid);
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
              padding: const EdgeInsets.only(top: 200),
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
                  return new SinglePaymentCard(
                    cardNumber,
                    cardHolderName,
                    cvvNumber,
                    expiryDate,
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

class SinglePaymentCard extends StatelessWidget {
  final cardNumber;
  final cardHolderName;
  final cvvNumber;
  final expiryDate;

  SinglePaymentCard(
      this.cardNumber, this.cardHolderName, this.cvvNumber, this.expiryDate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[100],
        height: 10,
        child: Row(
          children: [
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
                      cardNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cardHolderName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      expiryDate,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(right: 25)),
            new Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: new IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
